;=============================================================================
; @(#)xp-scheduler-library-test.asm
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
; Target.....: Microchip PIC 16F648A Microcontroller
; Compiler...: Microchip Assembler (MPASM)
; Version....: 1.1 2018/03/11 - source refactory
;              1.0 2017/05/20
; Description: Test program for xp-scheduler library
;=============================================================================

    PROCESSOR   16f648a
    __CONFIG    _CP_OFF & _DATA_CP_OFF & _LVP_OFF & _BOREN_OFF & _MCLRE_ON & _WDT_OFF & _PWRTE_ON & _HS_OSC
    INCLUDE     "../xp-pic-asm-scheduler-library.X/src/processor.inc"
    INCLUDE     "../xp-pic-asm-scheduler-library.X/src/xp-scheduler-library.inc"


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
        call   SCHEDULERinit
        call   SCHEDULERloop

        END                                     ; end program