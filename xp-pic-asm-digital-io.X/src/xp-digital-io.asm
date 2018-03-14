;=============================================================================
; @(#)xp-digital-io.asm
;                       ________.________
;   ____   ____  ______/   __   \   ____/
;  / ___\ /  _ \/  ___/\____    /____  \ 
; / /_/  >  <_> )___ \    /    //       \
; \___  / \____/____  >  /____//______  /
;/_____/            \/                \/ 
; Copyright (c) 2014 by Alessandro Fraschetti (gos95@gommagomma.net).
;
; This file is part of the xp-pic-asm project:
;     https://github.com/gos95-electronics/xp-pic-asm
; This code comes with ABSOLUTELY NO WARRANTY.
;
; Author.....: Alessandro Fraschetti
; Company....: gos95
; Target.....: Microchip PIC 16F628a Microcontroller
; Compiler...: Microchip Assembler (MPASM)
; Version....: 1.1 2018/03/13 - source refactory
;              1.0 2014/04/08
; Description: Simple management of input switches and output leds.
;=============================================================================

    PROCESSOR   16f648a
    __CONFIG    _CP_OFF & _DATA_CP_OFF & _LVP_OFF & _BOREN_OFF & _MCLRE_ON & _WDT_OFF & _PWRTE_ON & _HS_OSC
    INCLUDE     <p16f648a.inc>


;=============================================================================
;  Label equates
;=============================================================================
SWITCH          equ     PORTB
SW1             equ     0x00
SW2             equ     0x01
SW3             equ     0x02
SW4             equ     0x03

LED             equ     PORTA
LED1            equ     0x00
LED2            equ     0x01
LED3            equ     0x02
LED4            equ     0x03


;=============================================================================
;  File register use
;=============================================================================
    cblock	h'20'
        w_temp                          ; variable used for context saving
        status_temp                     ; variable used for context saving
        pclath_temp                     ; variable used for context saving

        d1, d2, d3                      ; the delay routine vars
        SWDOWNREG                       ; register for switches press state
        SWEVENTREG                      ; register for switches events state
    endc


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

        ; set PORTA JA1(A0-A3) as Output
        bcf			STATUS, RP0 			; select Bank0
        clrf		PORTA					; initialize PORTB by clearing output data latches
        movlw       h'07'                   ; turn comparators off
        movwf       CMCON                   ; and set port A mode I/O digital
        bsf			STATUS, RP0				; select Bank1
        movlw		b'11100000'				; PORTA input/output
  		movwf		TRISA

        ; set JB1 (B0-B3) as Input
        bcf			STATUS, RP0 			; select Bank0
        clrf		PORTB					; initialize PORTB by clearing output data latches
        bsf			STATUS, RP0				; select Bank1
        movlw		b'00001111'				; PORTB input/output
        movwf		TRISB
        clrf		STATUS					; select Bank0

        errorlevel  +302

        return


;=============================================================================
;  delay routines
;=============================================================================

;  1s delay routine (20MHz)
delay1s
        movlw       0x2C                    ;4999993 cycles
        movwf       d1
        movlw       0xE7
        movwf       d2
        movlw       0x0B
        movwf       d3
delay1s_loop
        decfsz      d1, F
        goto        $+2
        decfsz      d2, F
        goto        $+2
        decfsz      d3, F
        goto        delay1s_loop
        goto        $+1                     ;3 cycles
        nop

        return                              ;4 cycles (including call)


;  100ms delay routine (20MHz)
delay100ms
        movlw       0x03                    ;499994 cycles
        movwf       d1
        movlw       0x18
        movwf       d2
        movlw       0x02
        movwf       d3
delay100ms_loop
        decfsz      d1, F
        goto        $+2
        decfsz      d2, F
        goto        $+2
        decfsz      d3, F
        goto        delay100ms_loop
        goto        $+1                     ;2 cycles

        return                              ;4 cycles (including call)


;  50ms delay routine (20MHz)
delay50ms
        movlw       0x4E                    ;249993  cycles
        movwf       d1
        movlw       0xC4
        movwf       d2
delay50ms_loop
        decfsz      d1, F
        goto        $+2
        decfsz      d2, F
        goto        delay50ms_loop
        goto        $+1                     ;3 cycles
        nop

        return                              ;4 cycles (including call)


;  25ms delay routine (20MHz)
delay25ms
        movlw       0xA6                    ;124993  cycles
        movwf       d1
        movlw       0x62
        movwf       d2
delay25ms_loop
        decfsz      d1, F
        goto        $+2
        decfsz      d2, F
        goto        delay25ms_loop
        goto        $+1                     ;3 cycles
        nop

        return                              ;4 cycles (including call)


;  10ms delay routine (20MHz)
delay10ms
        movlw       0x0E                    ;49993 cycles
        movwf       d1
        movlw       0x28
        movwf       d2
delay10ms_loop
        decfsz      d1, F
        goto        $+2
        decfsz      d2, F
        goto        delay10ms_loop
        goto        $+1                     ;3 cycles
        nop

        return                              ;4 cycles (including call)


;  5ms delay routine (20MHz)
delay5ms
        movlw       0x86                    ;24993 cycles
        movwf       d1
        movlw       0x14
        movwf       d2
delay5ms_loop
        decfsz      d1, F
        goto        $+2
        decfsz      d2, F
        goto        delay5ms_loop
        goto        $+1                     ;3 cycles
        nop

        return                              ;4 cycles (including call)


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
;  Main program
;=============================================================================
main
		call 		init_ports

        clrf        SWDOWNREG
        clrf        SWEVENTREG
        bcf         LED, LED1
        bcf         LED, LED2
        bcf         LED, LED3
        bcf         LED, LED4

mainloop
        
switch_1_control ; momentary toggling switch with no debounce
        btfsc       SWITCH, SW1
        goto        switch_2_control
        btfsc       LED, LED1
        goto        $+3
        bsf         LED, LED1
        goto        switch_2_control
        bcf         LED, LED1

switch_2_control ; momentary toggling switch with event debounce
        btfsc       SWITCH, SW2             ; switch is pressed?
        goto        switch_1_release        ;   no, go to next switch

        btfsc       SWDOWNREG, SW2          ;   yes, was pressed on prev loop?
        goto        $+3                     ;     yes, managed pressed switch
        bsf         SWDOWNREG, SW2          ;     no, set SW pressed status
        goto        switch_3_control        ;     and go to next switch

        btfsc       SWEVENTREG, SW2         ; switch event already fired?
        goto        switch_3_control        ;   yes, do nothing and go to next switch

        bsf         SWEVENTREG, SW2         ;   no, do stuff...
        btfsc       LED, LED2
        goto        $+3
        bsf         LED, LED2
        goto        switch_3_control
        bcf         LED, LED2
switch_1_release
        bcf         SWDOWNREG, SW2            ; reset SW status registers
        bcf         SWEVENTREG, SW2           ;

switch_3_control ; momentary toggling switch with delay debounce
        btfsc       SWITCH, SW3
        goto        switch_4_control
        call        delay10ms
        btfsc       SWITCH, SW3
        goto        switch_4_control
        btfsc       LED, LED3
        goto        $+3
        bsf         LED, LED3
        goto        switch_4_control
        bcf         LED, LED3

switch_4_control ; momentary switch with delay to toggling momentary switch with debounce
end_sw_controls
        call        delay50ms
        goto        mainloop



;switch_2_control                            ; toggling momentary switch with debounce
;        btfsc       SWITCH, SW2
;        goto        switch_3_control
;        call        delay25ms
;        btfsc       SWITCH, SW2
;        goto        switch_3_control
;        btfsc       LED, LED2
;        goto        $+3
;        bsf         LED, LED2
;        goto        switch_3_control
;        bcf         LED, LED2
;
;
;switch_3_control                            ; momentary switch with no debounce
;        btfss       SWITCH, SW3
;        bsf         LED, LED3
;
;
;switch_4_control                            ; momentary switch with delay to
;                                            ; toggling momentary switch with debounce
;        btfsc       SWITCH, SW4
;        goto        end_sw_controls
;        bsf         LED, LED4
;
;        call        delay50ms
;        bsf         LED, LED4
;        call        delay50ms
;
;        btfsc       SWITCH, SW4
;        goto        end_sw_controls
;        btfsc       LED, LED4
;        goto        $+3
;        bsf         LED, LED4
;        goto        end_sw_controls
;        bcf         LED, LED4
;
;end_sw_controls
;        call        delay10ms
;        goto        mainloop

        end