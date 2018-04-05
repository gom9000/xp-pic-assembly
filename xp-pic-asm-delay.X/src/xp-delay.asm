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
; Target.....: Microchip PICmicro 16F648a Microcontroller
; Compiler...: Microchip Assembler (MPASM)
; Version....: 1.1 2018/03/11 - source refactory
;              1.0 2017/03/21
; Description: Simple implementation of 20MHz delay routines base on code from:
;              http://www.piclist.com/techref/piclist/codegen/delay.htm
;
;  cycles        20MHz   16MHz   10MHz   4MHz
;     500       100us    125us  200us   500us
;    2500       500us    625us    1ms   2.5ms
;    5000         1ms   1.25ms    2ms     5ms
;   10000         2ms    2.5ms    4ms    10ms
;   25000         5ms   6.25ms   10ms    25ms
;   50000        10ms   12.5ms   20ms    50ms
;  100000        20ms     25ms   40ms   100ms
;  250000        50ms   62.5ms  100ms   250ms
;  500000       100ms    125ms  200ms   500ms
; 1250000       250ms  312.5ms  500ms  1.25s
; 2500000       500ms    625ms    1s    2.5s
; 5000000         1s    1.25s     2s      5s
;=============================================================================

    PROCESSOR   16f648a
    INCLUDE     <p16f648a.inc>


;=============================================================================
;  CONFIGURATION
;=============================================================================
    __CONFIG    _CP_OFF & _DATA_CP_OFF & _LVP_OFF & _BOREN_OFF & _MCLRE_ON & _WDT_OFF & _PWRTE_ON & _HS_OSC


;=============================================================================
;  LABEL EQUATES
;=============================================================================
    constant MHZ_20 = .20
    constant MHZ_16 = .16
    constant MHZ_10 = .10
    constant MHZ_8  = .8
    constant MHZ_4  = .4
    constant MHZ_1  = .1

    constant OSCFREQ = MHZ_20


;=============================================================================
;  FILE REGISTER USE
;=============================================================================
    CBLOCK	0x020
        d1, d2, d3                              ; delay routines variables
    ENDC


;=============================================================================
;  MACROS
;=============================================================================

;
;  delay for ms milliseconds between 1 and 255
;
delayMS         MACRO   ms
    IF (ms > .250)
        ERROR "Maximum delay time allowed is 255ms"
    ENDIF
        movlw   (ms+.1)
    IF (OSCFREQ == .20)
        pagesel delay5000
        call    delay5000
    ELSE
    IF (OSCFREQ == .16)
        pagesel delay4000
        call    delay4000
    ELSE
    IF (OSCFREQ == .10)
        pagesel delay2500
        call    delay2500
    ELSE
    IF (OSCFREQ == .8)
        pagesel delay2000
        call    delay2000
    ELSE
    IF (OSCFREQ == .4)
        pagesel delay1000
        call    delay1000
    ELSE
    IF (OSCFREQ == .1)
        pagesel delay250
        call    delay250
    ELSE
        ERROR "OSCFREQ parameter not configured"
    ENDIF
    ENDIF
    ENDIF
    ENDIF
    ENDIF
    ENDIF
        pagesel $
                ENDM


;=============================================================================
;  RESET VECTOR
;=============================================================================
RESET           ORG     0x0000                  ; processor reset vector
        goto    MAIN                            ; jump to the main routine


;=============================================================================
;  ROUTINES multi OSCFREQ
;=============================================================================

;
;  500 cycles delay routine
;
delay500
        movlw       0xA5                        ;496 cycles
        movwf       d1
delay500_0
        decfsz      d1, F
        goto        delay500_0
	
        return                                  ;4 cycles (including call)


;
;  250 cycles delay routine (1ms on 1MHz)
;
delay250
        movwf       d3
delay250_inner1_loop
        decfsz      d3, F
        goto        $+2
        return

        movlw       0x51                        ;244 cycles
        movwf       d1
delay250_inner2_loop
        decfsz      d1, F
        goto        delay250_inner2_loop
        nop
        goto        delay250_inner1_loop


;
;  1000 cycles delay routine (1ms on 4MHz)
;
delay1000
        movwf       d3
delay1000_inner1_loop
        decfsz      d3, F
        goto        $+2
        return

        movlw       0xC6                        ;993 cycles
        movwf       d1
        movlw       0x01
        movwf       d2
delay1000_inner2_loop
        decfsz      d1, F
        goto        $+2
        decfsz      d2, F
        goto        delay1000_inner2_loop 
        goto        $+1
        goto        delay1000_inner1_loop


;
;  2000 cycles delay routine (1ms on 8MHz)
;
delay2000
        movwf       d3
delay2000_inner1_loop
        decfsz      d3, F
        goto        $+2
        return

        movlw       0x8E                        ;1993 cycles
        movwf       d1
        movlw       0x02
        movwf       d2
delay2000_inner2_loop
        decfsz      d1, F
        goto        $+2
        decfsz      d2, F
        goto        delay2000_inner2_loop 
        goto        $+1
        goto        delay2000_inner1_loop


;
;  2500 cycles delay routine (1ms on 10MHz)
;
delay2500
        movwf       d3
delay2500_inner1_loop
        decfsz      d3, F
        goto        $+2
        return

        movlw       0xF2                        ;2493 cycles
        movwf       d1
        movlw       0x02
        movwf       d2
delay2500_inner2_loop
        decfsz      d1, F
        goto        $+2
        decfsz      d2, F
        goto        delay2500_inner2_loop 
        goto        $+1
        goto        delay2500_inner1_loop


;
;  4000 cycles delay routine (1ms on 16MHz)
;
delay4000
        movwf       d3
delay4000_inner1_loop
        decfsz      d3, F
        goto        $+2
        return

        movlw       0x1E                        ;3993 cycles
        movwf       d1
        movlw       0x04
        movwf       d2
delay4000_inner2_loop
        decfsz      d1, F
        goto        $+2
        decfsz      d2, F
        goto        delay4000_inner2_loop 
        goto        $+1
        goto        delay4000_inner1_loop


;
; 5000 cycles delay routine (1ms on 20MHZ)
;
delay5000
        movwf       d3
delay5000_inner1_loop
        decfsz      d3, F
        goto        $+2
        return

        movlw       0xE6                        ;4993 cycles
        movwf       d1
        movlw       0x04
        movwf       d2
delay5000_inner2_loop
        decfsz      d1, F
        goto        $+2
        decfsz      d2, F
        goto        delay5000_inner2_loop 
        goto        $+1
        goto        delay5000_inner1_loop


;=============================================================================
;  ROUTINES for 20MHz OSCFREQ
;=============================================================================

;
;  1ms delay routine (20MHz)
;
delay1ms
        movlw       0xE6                        ;4993 cycles
        movwf       d1
        movlw       0x04
        movwf       d2
delay1ms_inner_loop
        decfsz      d1, F
        goto        $+2
        decfsz      d2, F
        goto        delay1ms_inner_loop 
        goto        $+1                         ;3 cycles
        nop

        return                                  ;4 cycles (including call)


;
;  10ms delay routine (20MHz)
;
delay10ms
        movlw       0x0E                        ;49993 cycles
        movwf       d1
        movlw       0x28
        movwf       d2
delay10ms_loop
        decfsz      d1, F
        goto        $+2
        decfsz      d2, F
        goto        delay10ms_loop
        goto        $+1                         ;3 cycles
        nop

        return                                  ;4 cycles (including call)


;
;  50ms delay routine (20MHz)
;
delay50ms
        movlw       0x4E                        ;249993  cycles
        movwf       d1
        movlw       0xC4
        movwf       d2
delay50ms_loop
        decfsz      d1, F
        goto        $+2
        decfsz      d2, F
        goto        delay50ms_loop
        goto        $+1                         ;3 cycles
        nop

        return                                  ;4 cycles (including call)


;
;  100ms delay routine (20MHz)
;
delay100ms
        movlw       0x03                        ;499994 cycles
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
        goto        $+1                         ;2 cycles

        return                                  ;4 cycles (including call)


;
;  250ms delay routine (20MHz)
;
delay250ms
        movlw       0x8A                        ;1249995 cycles
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
        nop                                     ;1 cycles

        return                                  ;4 cycles (including call)


;
;  500ms delay routine (20MHz)
;
delay500ms
        movlw       0x15                        ;2499992 cycles
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
        goto        $+1                         ;4 cycle
        goto        $+1

        return                                  ;4 cycles (including call)


;
;  1s delay routine (20MHz)
;
delay1s
        movlw       0x2C                        ;4999993 cycles
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
        goto        $+1                         ;3 cycles
        nop

        return                                  ;4 cycles (including call)


;=============================================================================
;  MAIN PROGRAM
;=============================================================================
MAIN                                            ; begin program
        nop
        delayMS     .1
        delayMS     .2
        delayMS     .5
        delayMS     .10
        delayMS     .25
        delayMS     .50
        delayMS     .100
        delayMS     .250

        call        delay1ms
        call        delay10ms
        call        delay50ms
        call        delay100ms
        call        delay250ms
        call        delay500ms
        call        delay1s
        nop

        END                                     ; end program