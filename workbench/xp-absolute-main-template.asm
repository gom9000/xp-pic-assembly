;=============================================================================
; @(#)filename.asm
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
; Target.....: Microchip PIC #pic_model# Microcontroller
; Compiler...: Microchip Assembler (MPASM)
; Version....: #x.y# #release_date# - #whatsnew#
;              #x.y# #release_date# - #whatsnew#
; Description: #program description#
;=============================================================================

    PROCESSOR   16f648a
    __CONFIG    _CP_OFF & _DATA_CP_OFF & _LVP_OFF & _BOREN_OFF & _MCLRE_ON & _WDT_OFF & _PWRTE_ON & _HS_OSC
;    __CONFIG   _CP_OFF & _DATA_CP_OFF & _LVP_OFF & _BOREN_OFF & _MCLRE_OFF & _WDT_OFF & _PWRTE_ON & _INTOSC_OSC_NOCLKOUT
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
;  Routine name and description
;=============================================================================


;=============================================================================
;  Main program
;=============================================================================
main
        nop

        end