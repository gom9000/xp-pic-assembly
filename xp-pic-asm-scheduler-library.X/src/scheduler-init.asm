;=============================================================================
; @(#)scheduler-init.asm
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
; Target.....: Microchip PIC 16F6x8A Microcontroller
; Compiler...: Microchip Assembler (MPASM)
; Version....: 1.1 2018/03/11 - source refactory
;              1.0 2017/05/20
;
; Module.....: SCHEDULERinit
; Description: Initialize the SCHEDULER
;=============================================================================

        TITLE       'SCHEDULERinit - Initialize the scheduler'
        SUBTITLE    'Part of the xp-pic-asm-scheduler-library'


        INCLUDE     processor.inc
        INCLUDE     scheduler-labels.inc


        GLOBAL      SCHEDULERinit
        GLOBAL      SCREG
        GLOBAL      sc1Counter
        GLOBAL      sc2Counter
        GLOBAL      sc3Counter
        GLOBAL      sc4Counter
        GLOBAL      sc5Counter
        GLOBAL      sc6Counter
        GLOBAL      sc7Counter
        GLOBAL      sc8Counter


;=============================================================================
; Variable declarations
;=============================================================================
GPR_VAR         UDATA
SCREG           RES         1                   ; scheduler bitflags register

sc1Counter      RES         1                   ; 2ms counter
sc2Counter      RES         1                   ; 10ms counter
sc3Counter      RES         1                   ; 50ms counter
sc4Counter      RES         1                   ; 100ms counter
sc5Counter      RES         1                   ; 250ms counter
sc6Counter      RES         1                   ; 500ms counter
sc7Counter      RES         1                   ; 1s counter
sc8Counter      RES         1                   ; 2s counter


;=============================================================================
; Module
;=============================================================================
        CODE                                    ; begin module
SCHEDULERinit

timer0_init
        clrf        STATUS                      ; select Bank0
        clrf        TMR0                        ; clear timer0 register

        bcf         INTCON, T0IE                ; mask timer interrupt

        bsf         STATUS, RP0                 ; select Bank1
        movlw       b'10000010'                 ; setup prescaler and timer (1:8)
        movwf       OPTION_REG
        bcf         STATUS, RP0                 ; select Bank0

counters_reset
        movlw       SC1CYCLES
        movwf       sc1Counter
        movlw       SC2CYCLES
        movwf       sc2Counter
        movlw       SC3CYCLES
        movwf       sc3Counter
        movlw       SC4CYCLES
        movwf       sc4Counter
        movlw       SC5CYCLES
        movwf       sc5Counter
        movlw       SC6CYCLES
        movwf       sc6Counter
        movlw       SC7CYCLES
        movwf       sc7Counter
        movlw       SC8CYCLES
        movwf       sc8Counter

        return

        END                                     ; end module