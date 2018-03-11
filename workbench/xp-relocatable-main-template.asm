;=============================================================================
; @(#)filename.ext
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
    INCLUDE     "../xp-pic-asm-xxx-library.X/src/xp-xxx-library.inc"


;=============================================================================
; Variable definitions
;=============================================================================


;=============================================================================
; Reset vector
;=============================================================================
RESET   CODE    0x0000                          ; processor reset vector
        goto    START                           ; go to beginning of program


;=============================================================================
; Main program
;=============================================================================
        CODE                                    ; begin program
START
		nop

        END                                     ; end program