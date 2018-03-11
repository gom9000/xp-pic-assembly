;=============================================================================
; @(#)xp-pic-usart.asm  0.1  2014/12/22
;   ________        _________________.________
;  /  _____/  ____ /   _____/   __   \   ____/
; /   \  ___ /  _ \\_____  \\____    /____  \
; \    \_\  (  <_> )        \  /    //       \
;  \______  /\____/_______  / /____//______  /
;         \/              \/               \/
; Copyright (c) 2014 by Alessandro Fraschetti.
; All Rights Reserved.
;
; Description: Simple RS232 serial communication echo
; Target.....: Microchip PIC 16F6x8a Microcontroller
; Compiler...: Microchip Assembler (MPASM)
; Note.......: 
;=============================================================================

        processor   16f628A
        __CONFIG   _CP_OFF & _CPD_OFF & _LVP_OFF & _BOREN_OFF & _MCLRE_ON & _WDT_OFF & _PWRTE_ON & _HS_OSC
					; _CP_[ON/OFF]    : code protect program memory enable/disable
                    ; _CPD_[ON/OFF]   : code protect data memory enable/disable
                    ; _LVP_[ON/OFF]   : Low Voltage ICSP enable/disable
					; _BOREN_[ON/OFF] : Brown-Out Reset enable/disable
					; _WDT_[ON/OFF]   : watchdog timer enable/disable
					; _MCLRE_[ON/OFF] : MCLR pin function  digital IO/MCLR
					; _PWRTE_[ON/OFF] : power-up timer enable/disable


;=============================================================================
;  Label equates
;=============================================================================
        #include    <p16f628a.inc>      ; standard labels

        errorlevel	-207
        FREAME_ERR      equ     b'0001'
        OVRUN_ERR       equ     b'0010'
        TABLE_EOF       equ     0x0a
        errorlevel	+207


;=============================================================================
;  File register use
;=============================================================================
		cblock		h'20'
			w_temp						; variable used for context saving
			status_temp					; variable used for context saving
            pclath_temp                 ; variable used for context saving
			d1, d2, d3					; delay routine vars

            databyte
            errorcode
            table_pointer
            table_element
		endc


;=============================================================================
;  Start of code
;=============================================================================
;start
		org			h'0000'				; processor reset vector
		goto		main				; jump to the main routine

		org			h'0004'				; interrupt vector location
		movwf		w_temp				; save off current W register contents
		swapf		STATUS, W			; move status register into W register
		movwf		status_temp			; save off contents of STATUS register
        swapf       PCLATH, W           ; move pclath register into W register
        movwf       pclath_temp         ; save off contents of PCLATH register

        ; isr code can go here or be located as a call subroutine elsewhere

        swapf       pclath_temp, W      ; retrieve copy of PCLATH register
        movwf       PCLATH              ; restore pre-isr PCLATH register contents
		swapf		status_temp, W		; retrieve copy of STATUS register
		movwf		STATUS				; restore pre-isr STATUS register contents
		swapf		w_temp, F
		swapf		w_temp, W			; restore pre-isr W register contents
		retfie							; return from interrupt


;=============================================================================
;  Init I/O ports
;    set RB1 (RX) and RB2(TX) as Input, the others PIN as Output.
;=============================================================================
init_ports:

		errorlevel	-302

  		bcf			STATUS, RP0				; select Bank0
;  		clrf		PORTB					; initialize PORTB by clearing output data latches
        movlw       b'00000100'             ; RB2(TX) = 1 others are 0
        movwf       PORTB
  		bsf			STATUS, RP0				; select Bank1
  		movlw		b'00000110'				; PORTB input/output
  		movwf		TRISB
        bcf			STATUS, RP0				; select Bank0

		errorlevel  +302

  		return


;=============================================================================
;  Init USART
;=============================================================================
init_usart:
        errorlevel	-302

        bsf			STATUS, RP0				; select Bank1
        bcf         TXSTA, TX9              ; 8-bit tx
        bcf         TXSTA, TXEN             ; disable tx
        bcf         TXSTA, SYNC             ; asynchronous mode
        bsf         TXSTA, BRGH             ; high bound rate
;        movlw   	h'81'             		; 9600 bauds on 20MHz osc. (BRGH=1)
;        movlw   	d'85'             		; 14400 bauds on 20MHz osc. (BRGH=1)
;        movlw   	d'21'             		; 56000 bauds on 20MHz osc. (BRGH=1)
;        movlw   	d'08'             		; 128K bauds on 20MHz osc. (BRGH=1)
;        movlw   	d'40'             		; 31250 bauds on 20MHz osc. (BRGH=1)
        movlw   	d'09'             		; 31250 bauds on 20MHz osc. (BRGH=0)
;        movlw   	d'07'             		; 31250 bauds on 4MHz osc. (BRGH=1)
        movwf   	SPBRG                   ;
        bsf         TXSTA, TXEN             ; enable tx

        bcf     	STATUS, RP0             ; select Bank0
        bsf         RCSTA, SPEN             ; enable serial port
        bcf         RCSTA, RX9              ; 8-bit rx
        bsf         RCSTA, CREN             ; enable continuous rx
        bcf			STATUS, RP0				; select Bank0

        errorlevel  +302

        return


;=============================================================================
;  TX routines
;=============================================================================
send_char_and_wait:
        movwf   	TXREG   				; load tx register with W
        nop
		btfss       PIR1, TXIF              ; wait for end of transmission
		goto  		$-1

		return

tx_wait:
		btfss       PIR1, TXIF              ; wait for end of transmission
		goto  		$-1

		return

;=============================================================================
;  RX routines
;=============================================================================
wait_until_receive_char:
		btfss       PIR1, RCIF              ; wait for data
		goto  		$-1

        btfsc       RCSTA, OERR             ; test for overrun error
        goto        errOERR
        btfsc       RCSTA, FERR             ; test for frame error
        goto        errFERR

        movf        RCREG, W                ; read received data
        movwf       databyte
        return

errOERR
        bcf         RCSTA, CREN
        bsf         RCSTA, CREN
        movlw       OVRUN_ERR
        movwf       errorcode
        return

errFERR
        movf        RCREG ,W
        movlw       OVRUN_ERR
        movwf       errorcode
        return


;=============================================================================
;  RX/TX handler routines
;=============================================================================
error_handler:

        return


;=============================================================================
;  main routine
;=============================================================================
main
		call 		init_ports
        call		init_usart

send_hello_message
        clrf        table_pointer           ; reset table pointer
next_element
        movf        table_pointer, W        ; load table pointer
        call        table_hello             ; get table element
        movwf       table_element           ; store table element
        call        send_char_and_wait      ; send table element

        movf        table_element, W        ; load table element
        sublw       TABLE_EOF
        btfsc       STATUS, Z               ; check pointer
        goto        mainloop
        incf        table_pointer, F        ; pointer to next table element
        goto        next_element

mainloop
        call        wait_until_receive_char
        movf        errorcode, F
        btfss       STATUS, Z
        call        error_handler

        movf        databyte, W
        call        send_char_and_wait

        goto        mainloop


table_hello:
        addwf       PCL, F                  ; modify program counter
        retlw       'H'
        retlw       'e'
        retlw       'l'
        retlw       'l'
        retlw       'o'
        retlw       '!'
        retlw       0x0d                    ; CR
        retlw       0x0a                    ; LF

        end
