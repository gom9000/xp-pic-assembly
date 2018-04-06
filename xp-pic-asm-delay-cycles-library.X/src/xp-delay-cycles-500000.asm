;=============================================================================
; @(#)xp-delay-cycles-500000.asm
;                       ________.________
;   ____   ____  ______/   __   \   ____/
;  / ___\ /  _ \/  ___/\____    /____  \ 
; / /_/  >  <_> )___ \    /    //       \
; \___  / \____/____  >  /____//______  /
;/_____/            \/                \/ 
; Copyright (c) 2018 by Alessandro Fraschetti (gos95@gommagomma.net).
;
; This file is part of the xp-pic-asm project:
;     https://github.com/gos95-electronics/xp-pic-asm
; This code comes with ABSOLUTELY NO WARRANTY.
;
; Author.....: Alessandro Fraschetti
; Company....: gos95
; Target.....: Microchip Mid-Range PICmicro
; Compiler...: Microchip Assembler (MPASM)
; Version....: 1.0 2018/03/09
;
; Module.....: xpDelay500000
; Description: 500000 cycles delay routine
;=============================================================================

    TITLE       'xpDelay500000 - 500000 cycles delay'
    SUBTITLE    'Part of the xp-delay-cycles-library'

    GLOBAL      xpDelay500000


;=============================================================================
;  VARIABLE DEFINITIONS
;=============================================================================
; Unitialized Data Section
GPR_MODULE_VAR      UDATA
localvar1           RES     1
localvar2           RES     1
localvar3           RES     1


;=============================================================================
;  MODULE PROGRAM
;=============================================================================
MODULE              CODE                        ; begin module
xpDelay500000
        movlw       0x03                        ; 499994 cycles
        movwf       localvar1
        movlw       0x18
        movwf       localvar2
        movlw       0x02
        movwf       localvar3
delay500000_loop
        decfsz      localvar1, F
        goto        $+2
        decfsz      localvar2, F
        goto        $+2
        decfsz      localvar3, F
        goto        delay500000_loop
        goto        $+1                         ; 2 cycles

        return                                  ; 4 cycles (including call)

        END                                     ; end module