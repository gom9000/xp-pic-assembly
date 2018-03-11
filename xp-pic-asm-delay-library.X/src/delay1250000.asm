;=============================================================================
; @(#)delay1250000.asm
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
; Target.....: Microchip PIC 16Fxxx Microcontroller
; Compiler...: Microchip Assembler (MPASM)
; Version....: 1.0 2018/03/09
;
; Module.....: DELAY1250000
; Description: 1250000 cycles delay routine
;=============================================================================

        TITLE       'DELAY1250000 - 1250000 cycles delay'
        SUBTITLE    'Part of the xp-delay-library'

        GLOBAL      DELAY1250000


;=============================================================================
; Variable declarations
;=============================================================================
GPR_VAR         UDATA
localvar1       RES         1
localvar2       RES         1
localvar3       RES         1


;=============================================================================
; Module
;=============================================================================
        CODE                                    ; begin module
DELAY1250000
        movlw       0x8A                        ; 1249995 cycles
        movwf       localvar1
        movlw       0xBA
        movwf       localvar2
        movlw       0x03
        movwf       localvar3
delay1250000_loop
        decfsz      localvar1, F
        goto        $+2
        decfsz      localvar2, F
        goto        $+2
        decfsz      localvar3, F
        goto        delay1250000_loop
        nop                                     ; 1 cycles

        return                                  ; 4 cycles (including call)

        END                                     ; end module