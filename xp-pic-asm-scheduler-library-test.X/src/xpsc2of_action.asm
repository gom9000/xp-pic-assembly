;=============================================================================
; @(#)xpsc2of_action.asm
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
;
; Routine....: xpsc2of_action
; Description: action code for SC2 period task
;
;  This routine must be overrided with task code.
;=============================================================================

        GLOBAL      xpsc2of_action


;=============================================================================
; Task
;=============================================================================
        CODE                                    ; begin module
xpsc2of_action

        nop

        return

        END                                     ; end module
