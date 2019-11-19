;=============================================================================
; @(#)scheduler-init.asm
;                       ________.________
;   ____   ____  ______/   __   \   ____/
;  / ___\ /  _ \/  ___/\____    /____  \ 
; / /_/  >  <_> )___ \    /    //       \
; \___  / \____/____  >  /____//______  /
;/_____/            \/                \/ 
; Copyright (c) 2017 Alessandro Fraschetti (gos95@gommagomma.net).
;
; This file is part of the xp-pic-assembly project:
;     https://github.com/gom9000/xp-pic-assembly
;
; Author.....: Alessandro Fraschetti
; Company....: gos95
; Target.....: Microchip Mid-Range PICmicro
; Compiler...: Microchip Assembler (MPASM)
; Version....: 1.1 2018/03/11 - source refactory
;              1.0 2017/05/20
;
; Module.....: SCHEDULERinit
; Description: Initialize the SCHEDULER
;=============================================================================
; Permission is hereby granted, free of charge, to any person obtaining a copy
; of this software and associated documentation files (the "Software"), to deal
; in the Software without restriction, including without limitation the rights
; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
; copies of the Software, and to permit persons to whom the Software is
; furnished to do so, subject to the following conditions:

; The above copyright notice and this permission notice shall be included in all
; copies or substantial portions of the Software.

; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
; SOFTWARE.
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
;  VARIABLE DEFINITIONS
;=============================================================================
; Shared Uninitialized Data Section
XP_SCHEDULER_VAR    UDATA_SHR
SCREG               RES     1                   ; scheduler bitflags register
sc1Counter          RES     1                   ; 2ms counter
sc2Counter          RES     1                   ; 10ms counter
sc3Counter          RES     1                   ; 50ms counter
sc4Counter          RES     1                   ; 100ms counter
sc5Counter          RES     1                   ; 250ms counter
sc6Counter          RES     1                   ; 500ms counter
sc7Counter          RES     1                   ; 1s counter
sc8Counter          RES     1                   ; 2s counter


;=============================================================================
;  MODULE PROGRAM
;=============================================================================
XP_SCHEDULER_INIT   CODE                        ; begin module
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