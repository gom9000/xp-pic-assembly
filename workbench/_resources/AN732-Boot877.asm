;=============================================================================
; Software License Agreement
;
; The software supplied herewith by Microchip Technology Incorporated 
; (the "Company") for its PICmicro® Microcontroller is intended and 
; supplied to you, the Company’s customer, for use solely and 
; exclusively on Microchip PICmicro Microcontroller products. The 
; software is owned by the Company and/or its supplier, and is 
; protected under applicable copyright laws. All rights are reserved. 
; Any use in violation of the foregoing restrictions may subject the 
; user to criminal sanctions under applicable laws, as well as to 
; civil liability for the breach of the terms and conditions of this 
; license.
;
; THIS SOFTWARE IS PROVIDED IN AN "AS IS" CONDITION. NO WARRANTIES, 
; WHETHER EXPRESS, IMPLIED OR STATUTORY, INCLUDING, BUT NOT LIMITED 
; TO, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A 
; PARTICULAR PURPOSE APPLY TO THIS SOFTWARE. THE COMPANY SHALL NOT, 
; IN ANY CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL OR 
; CONSEQUENTIAL DAMAGES, FOR ANY REASON WHATSOEVER.
;
;=============================================================================
;	Filename:	boot877.asm
;=============================================================================
;	Author:		Mike Garbutt
;	Company:	Microchip Technology Inc.
;	Revision:	1.00
;	Date:		26 June 2000
;	Assembled using MPASM V2.40
;=============================================================================
;	Include Files:	p16f877.inc	V1.00
;=============================================================================
;	Boot code to receive a hex file containing user code from a
;	serial port and write it to program memory. Tests a pin to see
;	if code should be downloaded. Receives hex file using USART and
;	hardware handshaking. Does error checking on data and writes to
;	program memory. Waits for reset and then starts user code running.
;=============================================================================

	list p=16f877, st=OFF, x=OFF, n=0
	errorlevel -302
	#include <p16f877.inc>

	__CONFIG _BODEN_OFF & _CP_OFF & _PWRTE_ON & _WDT_OFF & _WRT_ENABLE_ON & _XT_OSC & _DEBUG_OFF & _CPD_OFF & _LVP_OFF

;-----------------------------------------------------------------------------
;Constants

TEST_INPUT	EQU	0	;Port B Pin 0 input indicates download
RTS_OUTPUT	EQU	1	;Port B Pin 1 output for flow control
CTS_INPUT	EQU	2	;Port B Pin 2 input for flow control

BAUD_CONSTANT	EQU	0x19	;Constant for baud generator for 9600 baud
;BAUD_CONSTANT	EQU	0x0c	;Constant for baud generator for 19200 baud
				;Fosc is 4MHz

;-----------------------------------------------------------------------------
;Variables in bank0

		CBLOCK	0x20
		AddressH:	1	;flash program memory address high byte
		AddressL:	1	;flash program memory address low byte
		NumWords:	1	;number of words in line of hex file
		Checksum:	1	;byte to hold checksum of incoming data
		Counter:	1	;to count words being saved or programmed
		TestByte:	1	;byte to show reset vector code received
		HexByte:	1	;byte from 2 incoming ascii characters
		DataPointer:	1	;pointer to data in buffer
		DataArray:	0x40	;buffer for storing incoming data
		ENDC

;-----------------------------------------------------------------------------
;Macros to select the register bank
;Many bank changes can be optimised when only one STATUS bit changes

Bank0		MACRO			;macro to select data RAM bank 0
		bcf	STATUS,RP0
		bcf	STATUS,RP1
		ENDM

Bank1		MACRO			;macro to select data RAM bank 1
		bsf	STATUS,RP0
		bcf	STATUS,RP1
		ENDM

Bank2		MACRO			;macro to select data RAM bank 2
		bcf	STATUS,RP0
		bsf	STATUS,RP1
		ENDM

Bank3		MACRO			;macro to select data RAM bank 3
		bsf	STATUS,RP0
		bsf	STATUS,RP1
		ENDM

;=============================================================================
;Reset vector code

		ORG	0x0000 

ResetVector:	movlw	high Main
		movwf	PCLATH		;set page bits for page3
  		goto    Main		;go to boot loader

;=============================================================================
;Start of boot code in upper memory traps accidental entry into boot code area

		ORG	0x1f20		;Use last part of page3 for PIC16F876/7
;		ORG	0x0f20		;Use last part of page1 for PIC16F873/4
;		ORG	0x0720		;Use last part of page0 for PIC16F870/1

StartOfBoot:	movlw	high TrapError	;trap if execution runs into boot code
		movwf	PCLATH		;set correct page
TrapError:	goto	TrapError	;trap error and wait for reset

;-----------------------------------------------------------------------------
;Relocated user reset code to jump to start of user code
;Must be in bank0 before jumping to this routine

StartUserCode:	clrf	PCLATH		;set correct page for reset condition 
		nop			;relocated user code replaces this nop
		nop			;relocated user code replaces this nop
		nop			;relocated user code replaces this nop
		nop			;relocated user code replaces this nop
		movlw	high TrapError1	;trap if no goto in user reset code
		movwf	PCLATH		;set correct page
TrapError1:	goto	TrapError1	;trap error and wait for reset

;-----------------------------------------------------------------------------
;Program memory location to show whether valid code has been programmed

CodeStatus:	DA	0x3fff		;0 for valid code, 0x3fff for no code

;-----------------------------------------------------------------------------
;Main boot code routine
;Tests to see if a load should occur and if valid user code exists

Main:		Bank0			;change to bank0 in case of soft reset
		btfss	PORTB,TEST_INPUT ;check pin for boot load		
		goto	Loader		;if low then do bootload
		call	LoadStatusAddr	;load address of CodeStatus word
		call	FlashRead	;read data at CodeStatus location
		Bank2			;change from bank3 to bank2
		movf	EEDATA,F	;set Z flag if data is zero
		Bank0			;change from bank2 to bank0
		btfss	STATUS,Z	;test Z flag
TrapError2:	goto	TrapError2	;if not zero then is no valid code
		goto	StartUserCode	;if zero then run user code

;-----------------------------------------------------------------------------
;Start of routine to load and program new code

Loader:		clrf	TestByte	;indicate no reset vector code yet

		call	LoadStatusAddr	;load address of CodeStatus word
		movlw	0x3f		;load data to indicate no program
		movwf	EEDATH
		movlw	0xff		;load data to indicate no program
		movwf	EEDATA
		call	FlashWrite	;write new CodeStatus word

		call	SerialSetup	;set up serial port

;-----------------------------------------------------------------------------
;Get new line of hex file starting with ':'
;Get first 8 bytes after ':' and extract address and number of bytes

GetNewLine:	call	SerialReceive	;get new byte from serial port
		xorlw	':'		;check if ':' received
		btfss	STATUS,Z
		goto	GetNewLine	;if not then wait for next byte

		clrf	Checksum	;start with checksum zero

		call	GetHexByte	;get number of program data bytes in line
		andlw	0x1F		;limit number in case of error in file
		movwf	NumWords
		bcf	STATUS,C
		rrf	NumWords,F	;divide by 2 to get number of words

		call	GetHexByte	;get upper half of program start address
		movwf	AddressH

		call	GetHexByte	;get lower half of program start address
		movwf	AddressL

		bcf	STATUS,C
		rrf	AddressH,F	;divide address by 2 to get word address
		rrf	AddressL,F

		call	GetHexByte	;get record type
		xorlw	0x01
		btfsc	STATUS,Z	;check if end of file record (0x01)
		goto	FileDone	;if end of file then all done

		movf	HexByte,W
		xorlw	0x00
		btfss	STATUS,Z	;check if regular line record (0x00)
		goto	LineDone	;if not then ignore line and send '.'

		movlw	0xe0
		addwf	AddressH,W	;check if address < 0x2000
		btfsc	STATUS,C	;which is ID locations and config bits
		goto	LineDone	;if so then ignore line and send '.'

;-----------------------------------------------------------------------------
;Get data bytes and checksum from line of hex file

		movlw	DataArray
		movwf	FSR		;set pointer to start of array
		movf	NumWords,W
		movwf	Counter		;set counter to number of words

GetData:	call	GetHexByte	;get low data byte
		movwf	INDF		;save in array
		incf	FSR,F		;point to high byte

		call	GetHexByte	;get high data byte
		movwf	INDF		;save in array
		incf	FSR,F		;point to next low byte

		decfsz	Counter,F
		goto	GetData

		call	GetHexByte	;get checksum
		movf	Checksum,W	;check if checksum correct
		btfss	STATUS,Z
		goto	ErrorMessage

		bsf	PORTB,RTS_OUTPUT ;set RTS off to stop data being received

;-----------------------------------------------------------------------------
;Get saved data one word at a time to program into flash 

		movlw	DataArray
		movwf	FSR		;point to start of array
		movf	NumWords,W
		movwf	Counter		;set counter to half number of bytes

;-----------------------------------------------------------------------------
;Check if address is in reset code area

CheckAddress:	movf	AddressH,W	;checking for boot location code
		btfss	STATUS,Z	;test if AddressH is zero 
		goto	CheckAddress1	;if not go check if reset code received

		movlw	0xfc	
		addwf	AddressL,W	;add 0xfc (-4) to address
		btfsc	STATUS,C	;no carry means address < 4
		goto	CheckAddress1	;if not go check if reset code received

		bsf	TestByte,0	;show that reset vector code received
		movf	AddressL,W	;relocate addresses 0-3 to new location
		addlw	low (StartUserCode + 1) ;add low address to new location
		Bank2			;change from bank0 to bank2
		movwf	EEADR		;load new low address
		movlw	high (StartUserCode + 1) ;get new location high address
		movwf	EEADRH		;load high address
		goto	LoadData	;go get data byte and program into flash

;-----------------------------------------------------------------------------
;Check if reset code has been received
;Check if address is too high and conflicts with boot loader

CheckAddress1:	btfss	TestByte,0	;check if reset vector code received first
		goto	ErrorMessage	;if not then error

		movlw	high StartOfBoot ;get high byte of address
		subwf	AddressH,W
		btfss	STATUS,C	;test if less than boot code address 
		goto	LoadAddress	;yes so continue with write
		btfss	STATUS,Z	;test if equal to boot code address 
		goto	ErrorMessage	;no so error in high byte of address

		movlw	low StartOfBoot	;get low byte of address
		subwf	AddressL,W
		btfsc	STATUS,C	;test if less than boot code address 
		goto	ErrorMessage	;no so error in address

;-----------------------------------------------------------------------------
;Load address and data and write data into flash

LoadAddress:	movf	AddressH,W	;get high address
		Bank2			;change from bank0 to bank2
		movwf	EEADRH		;load high address
		Bank0			;change from bank2 to bank0
		movf	AddressL,W	;get low address
		Bank2			;change from bank0 to bank2
		movwf	EEADR		;load low address

LoadData:	movf	INDF,W		;get low byte from array
		movwf	EEDATA		;load low byte
		incf	FSR,F		;point to high data byte
		movf	INDF,W		;get high byte from array
		movwf	EEDATH		;load high byte
		incf	FSR,F		;point to next low data byte

		call	FlashWrite	;write data to program memory

		Bank0			;change from bank3 to bank0
		incfsz	AddressL,F	;increment low address byte
		goto	CheckLineDone	;check for rollover
		incf	AddressH,F	;if so then increment high address byte

CheckLineDone:	decfsz	Counter,F	;check if all words have been programmed
		goto	CheckAddress	;if not then go program next word

;-----------------------------------------------------------------------------
;Done programming line of file

LineDone:	movlw	'.'		;line has been programmed so
		call	SerialTransmit	;transmit progress indicator back
		goto	GetNewLine	;go get next line hex file

;-----------------------------------------------------------------------------
;Done programming file so send success indicator and trap execution until reset

FileDone:	movlw	'S'		;programming complete so
		call	SerialTransmit	;transmit success indicator back

		call	LoadStatusAddr	;load address of CodeStatus word
		clrf	EEDATH		;load data to indicate program exists
		clrf	EEDATA		;load data to indicate program exists
		call	FlashWrite
TrapFileDone:	goto	TrapFileDone	;all done so wait for reset

;-----------------------------------------------------------------------------
;Error in hex file so send failure indicator and trap error

ErrorMessage:	movlw	'F'		;error occurred so
		call	SerialTransmit	;transmit failure indicator back
TrapError3:	goto	TrapError3	;trap error and wait for reset

;-----------------------------------------------------------------------------
;Load address of CodeStatus word into flash memory address registers
;This routine returns in bank2

LoadStatusAddr:	Bank2			;change from bank0 to bank2
		movlw	high CodeStatus	;load high addr of CodeStatus location
		movwf	EEADRH
		movlw	low CodeStatus	;load low addr of CodeStatus location
		movwf	EEADR
		return

;-----------------------------------------------------------------------------
;Receive two ascii digits and convert into one hex byte
;This routine returns in bank0

GetHexByte:	call	SerialReceive	;get new byte from serial port
		addlw	0xbf		;add -'A' to Ascii high byte
		btfss	STATUS,C	;check if positive
		addlw	0x07		;if not, add 17 ('0' to '9')
		addlw	0x0a		;else add 10 ('A' to 'F') 
		movwf	HexByte		;save nibble
		swapf	HexByte,F	;move nibble to high position

		call	SerialReceive	;get new byte from serial port
		addlw	0xbf		;add -'A' to Ascii low byte
		btfss	STATUS,C	;check if positive
		addlw	0x07		;if not, add 17 ('0' to '9')
		addlw	0x0a		;else add 10 ('A' to 'F') 
		iorwf	HexByte,F	;add low nibble to high nibble
		movf	HexByte,W	;put result in W reg
		addwf	Checksum,F	;add to cumulative checksum
		return

;-----------------------------------------------------------------------------
;Set up USART for asynchronous comms
;Routine is only called once and can be placed in-line saving a call and return
;This routine returns in bank0

SerialSetup:	Bank0			;change from bank3 to bank0
		bsf	PORTB,RTS_OUTPUT ;set RTS off before setting as output
		Bank1			;change from bank0 to bank1
		bcf	TRISB,RTS_OUTPUT ;enable RTS pin as output
		movlw	BAUD_CONSTANT	;set baud rate 9600 for 4Mhz clock
		movwf	SPBRG
		bsf	TXSTA,BRGH	;baud rate high speed option
		bsf	TXSTA,TXEN	;enable transmission
		Bank0			;change from bank1 to bank0
		bsf	RCSTA,CREN	;enable reception
		bsf	RCSTA,SPEN	;enable serial port
		return

;-----------------------------------------------------------------------------
;Wait for byte to be received in USART and return with byte in W
;This routine returns in bank0

SerialReceive:	Bank0			;change from unknown bank to bank0
		bcf	PORTB,RTS_OUTPUT ;set RTS on for data to be received
		btfss	PIR1,RCIF	;check if data received
		goto	$-1		;wait until new data
		movf	RCREG,W		;get received data into W
		return

;-----------------------------------------------------------------------------
;Transmit byte in W register from USART
;This routine returns in bank0

SerialTransmit:	Bank0			;change from unknown bank to bank0
		btfsc	PORTB,CTS_INPUT	;check CTS to see if data can be sent
		goto	$-1
		btfss	PIR1,TXIF	;check that buffer is empty
		goto	$-1
		movwf	TXREG		;transmit byte
		return

;-----------------------------------------------------------------------------
;Write to a location in the flash program memory
;Address in EEADRH and EEADR, data in EEDATH and EEDATA
;This routine returns in bank3

FlashWrite:	Bank3			;change from bank2 to bank3
		movlw	0x84		;enable writes to program flash
		movwf	EECON1

		movlw	0x55		;do timed access writes
		movwf	EECON2
		movlw	0xaa
		movwf	EECON2
		bsf	EECON1,WR	;begin writing to flash

		nop			;processor halts here while writing
		nop
		return

;-----------------------------------------------------------------------------
;Read from a location in the flash program memory
;Address is in EEADRH and EEADR, data returned in EEDATH and EEDATA
;Routine is only called once and can be placed in-line saving a call and return
;This routine returns in bank3 and is called when in bank2

FlashRead:	movlw	0x1f		;keep address within range
		andwf	EEADRH,F

		Bank3			;change from bank2 to bank3
		movlw	0x80		;enable reads from program flash
		movwf	EECON1

		bsf	EECON1,RD	;read from flash

		nop			;processor waits while reading
		nop
		return

;-----------------------------------------------------------------------------

		END

