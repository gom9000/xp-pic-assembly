;=============================================================================
; @(#)xp-delay.asm
;                       ________.________
;   ____   ____  ______/   __   \   ____/
;  / ___\ /  _ \/  ___/\____    /____  \ 
; / /_/  >  <_> )___ \    /    //       \
; \___  / \____/____  >  /____//______  /
;/_____/            \/                \/ 
; Copyright (c) 2017 by Alessandro Fraschetti (gos95@gommagomma.net).
;
; This file is part of the xp-pic-asm project:
;     https://github.com/gos95-electronics/xp-pic-asm
; This code comes with ABSOLUTELY NO WARRANTY.
;
; Author.....: Alessandro Fraschetti
; Company....: gos95
; Target.....: Microchip PIC 16F648a Microcontroller
; Compiler...: Microchip Assembler (MPASM)
; Version....: 1.1 2018/03/11 - source refactory
;              1.0 2017/03/21
; Description: Simple implementation of 20MHz delay routines base on code from:
;              http://www.piclist.com/techref/piclist/codegen/delay.htm
;=============================================================================

    PROCESSOR   16f648a
    __CONFIG    _CP_OFF & _DATA_CP_OFF & _LVP_OFF & _BOREN_OFF & _MCLRE_ON & _WDT_OFF & _PWRTE_ON & _HS_OSC
    INCLUDE     <p16f648a.inc>


;=============================================================================
;  Label equates
;=============================================================================


;=============================================================================
;  File register use
;=============================================================================
	cblock		h'20'
		w_temp						; variable used for context saving
		status_temp					; variable used for context saving
        pclath_temp                 ; variable used for context saving

        d1, d2, d3                  ; delay routines variables
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
;  1ms delay routine (20MHz)
;=============================================================================
delay1ms
        movlw       0xE6                    ;4993 cycles
        movwf       d1
        movlw       0x04
        movwf       d2
delay1ms_inner_loop
        decfsz      d1, F
        goto        $+2
        decfsz      d2, F
        goto        delay1ms_inner_loop 
        goto        $+1                     ;3 cycles
        nop

        return                              ;4 cycles (including call)


;=============================================================================
;  10ms delay routine (20MHz)
;=============================================================================
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


;=============================================================================
;  50ms delay routine (20MHz)
;=============================================================================
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


;=============================================================================
;  100ms delay routine (20MHz)
;=============================================================================
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


;=============================================================================
;  250ms delay routine (20MHz)
;=============================================================================
delay250ms
        movlw       0x8A                    ;1249995 cycles
        movwf       d1
        movlw       0xBA
        movwf       d2
        movlw       0x03
        movwf       d3
delay250ms_loop
        decfsz      d1, F
        goto        $+2
        decfsz      d2, F
        goto        $+2
        decfsz      d3, F
        goto        delay250ms_loop
        nop                                 ;1 cycles

        return                              ;4 cycles (including call)


;=============================================================================
;  500ms delay routine (20MHz)
;=============================================================================
delay500ms
        movlw       0x15                    ;2499992 cycles
        movwf       d1
        movlw       0x74
        movwf       d2
        movlw       0x06
        movwf       d3
delay500ms_loop
        decfsz      d1, F
        goto        $+2
        decfsz      d2, F
        goto        $+2
        decfsz      d3, F
        goto        delay500ms_loop
        goto        $+1                     ;4 cycle
        goto        $+1

        return                              ;4 cycles (including call)


;=============================================================================
;  1s delay routine (20MHz)
;=============================================================================
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


;=============================================================================
;  Main program
;=============================================================================
main
        nop         
        call        delay1ms
        call        delay10ms
        call        delay50ms
        call        delay100ms
        call        delay250ms
        call        delay500ms
        call        delay1s
        nop

        end