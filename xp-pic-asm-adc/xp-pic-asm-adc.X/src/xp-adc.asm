;=============================================================================
; @(#)xp-adc.asm
;                       ________.________
;   ____   ____  ______/   __   \   ____/
;  / ___\ /  _ \/  ___/\____    /____  \ 
; / /_/  >  <_> )___ \    /    //       \
; \___  / \____/____  >  /____//______  /
;/_____/            \/                \/ 
; Copyright (c) 2024 Alessandro Fraschetti (gos95@gommagomma.net).
;
; This file is part of the xp-pic-assembly project:
;     https://github.com/gom9000/xp-pic-assembly
;
; Author.....: Alessandro Fraschetti
; Company....: gos95
; Target.....: Microchip MidRange PICmicro
; Compiler...: Microchip Assembler (MPASM)
; Version....: 1.1 2018/03/11 - source refactory
;              1.0 2017/03/21
; Description: Simple implementation of 20MHz delay routines base on code from:
;              http://www.piclist.com/techref/piclist/codegen/delay.htm
    ;This program is to read voltage output from a rheostat
; and display the value on a PC terminal (current is updated every 2 seconds)
;
; AN0 is connected to the rheostat wiper
;;
;USE ONLY most significant 8 bits stored in ADRESH
;Max 5.00 V
;min 0.00 V
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


    PROCESSOR   16f877a
    INCLUDE     <p16f877a.inc>


;=============================================================================
;  CONFIGURATION
;=============================================================================
    __CONFIG    _CP_OFF & _CPD_OFF & _LVP_OFF & _BOREN_OFF & _WDT_OFF & _PWRTE_ON & _HS_OSC
                ; _CP_[ON/OFF]    : code protect program memory enable/disable
                ; _CPD_[ON/OFF]   : code protect data memory enable/disable
                ; _LVP_[ON/OFF]   : Low Voltage ICSP enable/disable
                ; _BOREN_[ON/OFF] : Brown-Out Reset enable/disable
                ; _WDT_[ON/OFF]   : watchdog timer enable/disable
                ; _MCLRE_[ON/OFF] : MCLR pin function digitalIO/MCLR
                ; _PWRTE_[ON/OFF] : power-up timer enable/disable


;=============================================================================
;  CONSTANT DEFINITIONS
;=============================================================================
    constant MHZ_20 = .20
    constant MHZ_16 = .16
    constant MHZ_10 = .10
    constant MHZ_8  = .8
    constant MHZ_4  = .4
    constant MHZ_1  = .1

    constant OSCFREQ = MHZ_4



DPOT                EQU     PORTD
CS                  EQU     0x00
SCLK                EQU     0x01
SI                  EQU     0x02
COMMAND             EQU     b'00010011'


;=============================================================================
;  VARIABLE DEFINITIONS
;=============================================================================
    CBLOCK	0x020
        d1, d2, d3                              ; delay routines variables
        adc_value
        adc_value2
        adc_value_prev
        OUT, COUNT
    ENDC


;=============================================================================
;  MACROS
;=============================================================================

; ---------------------------------------------------------------------------
;  Delay for <ms> milliseconds between 1 and 255
; ---------------------------------------------------------------------------
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
RESET               ORG     0x0000              ; processor reset vector
        pagesel     MAIN
        goto        MAIN                        ; jump to the main routine


;=============================================================================
;  INIT ROUTINES
;=============================================================================
INIT_ROUTINES       CODE                        ; routines vector
init_ports

        errorlevel	-302

        ; init PORTA
        banksel     PORTA
        clrf        PORTA                       ; initialize PORTA by clearing output data latches

        banksel     TRISA
        movlw       h'03'                       ; RA<0:1> as input, RA2 as output
        movwf       TRISA

        movlw       b'00000100'                 ; RA<0:1,3> as analog input, RA<2,4:5> as digital
        banksel     ADCON1                      ; PORT A is for ADC channel, left-justification (8-bit adc values on ADRESH)
        movwf       ADCON1

        ; init PORTB
        banksel     PORTB
        clrf        PORTB                       ; initialize PORTB by clearing output data latches

        banksel     TRISB
        clrf        TRISB                       ; configure PORTB as output

        ; init PORTD
        banksel     PORTD
        clrf        PORTD                       ; initialize PORTD by clearing output data latches

        banksel     TRISD
        clrf        TRISD                       ; configure PORTD as output

        errorlevel  +302

        return


;=============================================================================
;  ROUTINES multi OSCFREQ
;=============================================================================

; ---------------------------------------------------------------------------
;  500 cycles delay routine
; ---------------------------------------------------------------------------
delay500
        movlw       0xA5                        ;496 cycles
        movwf       d1
delay500_0
        decfsz      d1, F
        goto        delay500_0
	
        return                                  ;4 cycles (including call)

; ---------------------------------------------------------------------------
;  250 cycles delay routine (1ms on 1MHz)
; ---------------------------------------------------------------------------
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

; ---------------------------------------------------------------------------
;  1000 cycles delay routine (1ms on 4MHz)
; ---------------------------------------------------------------------------
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

; ---------------------------------------------------------------------------
;  2000 cycles delay routine (1ms on 8MHz)
; ---------------------------------------------------------------------------
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

; ---------------------------------------------------------------------------
;  2500 cycles delay routine (1ms on 10MHz)
; ---------------------------------------------------------------------------
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

; ---------------------------------------------------------------------------
;  4000 cycles delay routine (1ms on 16MHz)
; ---------------------------------------------------------------------------
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

; ---------------------------------------------------------------------------
;  5000 cycles delay routine (1ms on 20MHz)
; ---------------------------------------------------------------------------
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

; ---------------------------------------------------------------------------
;  1ms delay routine (20MHz)
; ---------------------------------------------------------------------------
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


; ---------------------------------------------------------------------------
;  10ms delay routine (20MHz)
; ---------------------------------------------------------------------------
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


; ---------------------------------------------------------------------------
;  500ms delay routine (20MHz)
; ---------------------------------------------------------------------------
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


;Subroutine getADC =========================
getADC
        call        delay1ms ;warm up
        call        delay1ms ;warm up
        banksel     ADCON0
        bsf         ADCON0, GO ;start conversion
ADCloop
        btfsc       ADCON0, GO ;wait for conversion to finish
        goto        ADCloop
        bcf         PIR1, ADIF ;clear conversion complete flag
        movf        ADRESH, W

        return

;Subroutine sendData =========================
sendData
        movwf       OUT ;MOVE W TO ?OUT? VARIABLE
        MOVLW       0x08 ;LOAD A COUNTER TO ?COUNT? THE BIT
        MOVWF       COUNT ;TRANSMISSION
L_SHIFT BTFSC       OUT, 7 ;MONITOR THE 7TH BIT
        GOTO        HI
        BCF         DPOT, SI ;IF LOW: CLEAR SERIAL-IN LINE
        GOTO        PASS
HI      BSF         DPOT, SI ;IF HI: SET SERIAL-IN LINE
PASS    BSF         DPOT, SCLK ;SET SERIAL CLOCK: HI
        RLF         OUT, F ;ROTATE OUT LEFT
        BCF         DPOT, SCLK ;SET SERIAL CLOCK: LOW
        DECFSZ      COUNT, F ;DECREMENT COUNTER UNTIL ITS ZERO
        GOTO        L_SHIFT
        bcf         DPOT, SI
        bcf         DPOT, SCLK
;        CLRF        DPOT ;WHEN COUNTER IS ZERO IT?S END OF
                ;TRANSMISSION
        RETURN


;=============================================================================
;  MAIN PROGRAM
;=============================================================================
MAIN                                            ; begin program
        lcall       init_ports

        banksel     DPOT
        bsf         DPOT, CS
        
loop
        banksel     ADCON0
        movlw       b'11000001'
        movwf       ADCON0                      ; initialize ADC (RA0 is ADC port)
        call        getADC
        movwf       adc_value
        
        banksel     ADCON0
        movlw       b'11001001'
        movwf       ADCON0                      ; initialize ADC (RA1 is ADC port)
        call        getADC
        movwf       adc_value2
 
        banksel     PORTB
        movwf       PORTB

        banksel     DPOT
        bcf         DPOT, CS
        movlw       COMMAND
        call        sendData
        movf        adc_value, W
        call        sendData
        bsf         DPOT, CS

        call        delay1ms

        goto        loop

        END                                     ; end program