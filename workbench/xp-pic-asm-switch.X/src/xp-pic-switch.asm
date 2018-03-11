;=============================================================================
; @(#)xp-16f6x8-switch.asm  0.1  2014/04/08
;   ________        _________________.________
;  /  _____/  ____ /   _____/   __   \   ____/
; /   \  ___ /  _ \\_____  \\____    /____  \
; \    \_\  (  <_> )        \  /    //       \
;  \______  /\____/_______  / /____//______  /
;         \/              \/               \/
; Copyright (c) 2014 by Alessandro Fraschetti.
; All Rights Reserved.
;
; Description: Test TEBO SW4+LED4
; Input......:
; Output.....:
; Note.......:
;=============================================================================

    processor	16f648a
    #include	<p16f648a.inc>
    ;__config    _CP_OFF & _CPD_OFF & _BODEN_OFF & _LVP_OFF & _WDT_OFF & _PWRTE_ON & _HS_OSC
    ;__CONFIG    _CP_OFF & _DATA_CP_OFF & _LVP_OFF & _BOREN_OFF & _MCLRE_OFF & _WDT_OFF & _PWRTE_ON & _INTOSC_OSC_NOCLKOUT
    __CONFIG	_CP_OFF & _DATA_CP_OFF & _LVP_OFF & _BOREN_OFF & _MCLRE_ON & _WDT_OFF & _PWRTE_ON & _HS_OSC


;=============================================================================
;  File register use
;=============================================================================
    cblock	h'20'
        w_temp                          ; variable used for context saving
        status_temp                     ; variable used for context saving
        pclath_temp                     ; variable used for context saving

        d1, d2, d3                      ; the delay routine vars
    endc


;=============================================================================
;  Constants
;=============================================================================
    SWITCH      equ     PORTA
    SW1         equ     0x00
    SW2         equ     0x01
    SW3         equ     0x02
    SW4         equ     0x03

    LED         equ     PORTB
    LED1        equ     0x00
    LED2        equ     0x01
    LED3        equ     0x02
    LED4        equ     0x03


;=============================================================================
;  Start of code
;=============================================================================
;start
	org			h'0000'				; processor reset vector
	goto		main				; jump to the main routine

	org			h'0004'				; interrupt vector location
	movwf		w_temp				; save off current W register contents
	movf		STATUS, W			; move status register into W register
	movwf		status_temp			; save off contents of STATUS register
    movf        PCLATH, W           ; move pclath register into W register
    movwf       pclath_temp         ; save off contents of PCLATH register

    ; isr code can go here or be located as a call subroutine elsewhere

    movf        pclath_temp, W      ; retrieve copy of PCLATH register
    movwf       PCLATH              ; restore pre-isr PCLATH register contents
    movf		status_temp, W		; retrieve copy of STATUS register
	movwf		STATUS				; restore pre-isr STATUS register contents
	swapf		w_temp, F
	swapf		w_temp, W			; restore pre-isr W register contents
	retfie							; return from interrupt


;=============================================================================
;  Init I/O ports
;=============================================================================
init_ports

	errorlevel	-302

    ; set JA1 (A0-A3) as Input
    ; set JA2 (A4-A7) as Input
  	clrf		STATUS					; select Bank0
  	clrf		PORTA					; initialize PORTA by clearing output data latches
    movlw       h'07'                   ; turn comparators off
    movwf       CMCON
  	bsf			STATUS, RP0				; select Bank1
  	movlw		b'11111111'				; PORTA input/output
  	movwf		TRISA

    ; set JB1 (B0-B3) as Output
    ; set JB2 (B4-B7) as Output
  	clrf		STATUS					; select Bank0
  	clrf		PORTB					; initialize PORTB by clearing output data latches
  	bsf			STATUS, RP0				; select Bank1
  	movlw		b'00000000'				; PORTB input/output
  	movwf		TRISB
    clrf		STATUS					; select Bank0

    errorlevel  +302

    return


;=============================================================================
;  delay routines
;=============================================================================
delay1s
			;999990 cycles
	movlw	0x07
	movwf	d1
	movlw	0x2F
	movwf	d2
	movlw	0x03
	movwf	d3
Delay1s_0
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	$+2
	decfsz	d3, f
	goto	Delay1s_0

			;6 cycles
	goto	$+1
	goto	$+1
	goto	$+1

			;4 cycles (including call)
	return

delay10ms
			;49993 cycles
	movlw	0x0E
	movwf	d1
	movlw	0x28
	movwf	d2
Delay10ms_0
	decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	Delay10ms_0

			;3 cycles
	goto	$+1
	nop

			;4 cycles (including call)
	return


;=============================================================================
;  blink leds routines
;=============================================================================
blink_leds_10ms
        bsf         LED, LED1
        bsf         LED, LED2
        bsf         LED, LED3
        bsf         LED, LED4
        call        delay10ms
        bcf         LED, LED1
        bcf         LED, LED2
        bcf         LED, LED3
        bcf         LED, LED4
        call        delay10ms
        goto        blink_leds_10ms

        return

blink_leds_1s
        bsf         LED, LED1
        bsf         LED, LED2
        bsf         LED, LED3
        bsf         LED, LED4
        call        delay1s
        bcf         LED, LED1
        bcf         LED, LED2
        bcf         LED, LED3
        bcf         LED, LED4
        call        delay1s
        goto        blink_leds_1s

        return
;=============================================================================
;  main routine
;=============================================================================
main
		call 		init_ports

mainloop

 ;       call        blink_leds_10ms
        call        blink_leds_1s

        bcf         LED, LED1
        bcf         LED, LED2
        bcf         LED, LED3
        bcf         LED, LED4
        btfss       SWITCH, SW1
        bsf         LED, LED1
        btfss       SWITCH, SW2
        bsf         LED, LED2
        btfss       SWITCH, SW3
        bsf         LED, LED3
        btfss       SWITCH, SW4
        bsf         LED, LED4

        goto        mainloop


        end
