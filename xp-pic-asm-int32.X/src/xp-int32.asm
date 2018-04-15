;=============================================================================
; @(#)xp-int32.asm
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
; Target.....: Microchip PICmicro Mid-Range Microcontroller
; Compiler...: Microchip Assembler (MPASM)
; Version....: 1.0 2018/04/11 - start
; Description: 32-bit integer arithmetic
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
CF                  EQU     0x0
SF                  EQU     0x2
OF                  EQU     0x3


;=============================================================================
;  32-BIT PRECISION ARITHMETIC VARIABLE DEFINITIONS
;=============================================================================
GPR_DATA            UDATA
var1                RES     4                   ; 32-bit variables
var2                RES     4                   ;


;=============================================================================
;  32-BIT PRECISION ARITHMETIC VARIABLE DEFINITIONS
;=============================================================================
ARITH32_DATA        UDATA
STATUS32            RES     1                   ; 32-bit arithmetic status register:
                                                ; <0> carry flag
                                                ; <1> sign flag
                                                ; <2> overflow flag

accA                RES     4                   ; 32-bit accumulators
accB                RES     4                   ; little-endian byte ordering
accC                RES     4                   ;


;=============================================================================
;  RESET VECTOR
;=============================================================================
RESET               CODE    0x0000              ; processor reset vector
        pagesel     MAIN                        ; 
        goto        MAIN                        ; go to beginning of program


;=============================================================================
;  32-BIT PRECISION ARITHMETIC ROUTINE VECTOR
;=============================================================================
ARITH32_CODE        CODE

;*************************************************************************
; Load 32-bit values to accA
; Value LSB-address in W
;*************************************************************************
load_accA
        banksel     accA
        movlw       .10 & 0xFF
        movwf       accA
        movlw       .10 >> .08 % 0xFF
        movwf       accA+1
        movlw       .10 >> .16 % 0xFF
        movwf       accA+2
        movlw       .10 >> .24 % 0xFF
        movwf       accA+3
        return

;*************************************************************************
; Load 32-bit values to accB
; Value LSB-address in W
;*************************************************************************
load_accB
        banksel     accB
        movlw       .13 & 0xFF
        movwf       accB
        movlw       .13 >> .08 % 0xFF
        movwf       accB+1
        movlw       .13 >> .16 % 0xFF
        movwf       accB+2
        movlw       .13 >> .24 % 0xFF
        movwf       accB+3
        return

;*************************************************************************
; 32-bit Precision Addition: accA(32-bit) = accA(32-bit) + accB(32-bit)
; Status32 Affected: CF :
;                    SF :
;                    OF :
;*************************************************************************
add32
        banksel     STATUS32
        clrf        STATUS32

        movf        accB, W                     ; add byte 0 (LSB)
        addwf       accA, F
        movf        accB+1, W                   ; add byte 1
        btfsc       STATUS, C
        incfsz      accB+1, W
        addwf       accA+1, F
        movf        accB+2, W                   ; add byte 2
        btfsc       STATUS, C
        incfsz      accB+2, W
        addwf       accA+2, F
        movf        accB+3, W                   ; add byte 3 (MSB)
        btfsc       STATUS, C
        incfsz      accB+3, W
        addwf       accA+3, F
        btfsc       STATUS, C
        bsf         STATUS32, CF
        return

;*************************************************************************
; 32-bit Precision Subctraction: accA(32-bit) = accA(32-bit) - accB(32-bit)
; Status32 Affected: CF :
;                    SF :
;                    OF :
;*************************************************************************
sub32                                           ; var3 = var2 - var1
        banksel     STATUS32
        clrf        STATUS32

        movf        accA, W                     ; sub byte 0 (LSB)
        subwf       accA, F
        movf        accA+1, W                   ; sub byte 1
        btfss       STATUS, C
        incfsz      accA+1, W
        subwf       accA+1, F
        movf        accA+2, W                   ; sub byte 2
        btfss       STATUS, C
        incfsz      accA+2, W
        subwf       accA+2, F
        movf        accA+3, W                   ; sub byte 3 (MSB)
        btfss       STATUS, C
        incfsz      accA+3, W
        subwf       accA+3, F
;        btfsc       STATUS, C
;        bsf         ARITH32REG, OVERFLOW
        return


;=============================================================================
;  MAIN PROGRAM
;=============================================================================
MAINPROGRAM         CODE                        ; begin program
MAIN
        banksel     var1
        movlw       .10 & 0xFF
        movwf       var1
        movlw       .10 >> .08 % 0xFF
        movwf       var1+1
        movlw       .10 >> .16 % 0xFF
        movwf       var1+2
        movlw       .10 >> .24 % 0xFF
        movwf       var1+3

        movlw       .11 & 0xFF
        movwf       var2
        movlw       .11 >> .08 % 0xFF
        movwf       var2+1
        movlw       .11 >> .16 % 0xFF
        movwf       var2+2
        movlw       .11 >> .24 % 0xFF
        movwf       var2+3


        banksel     var1
        movlw       var1
        pagesel     load_accA
        call        load_accA

        banksel     var2
        movlw       var2
        pagesel     load_accB
        call        load_accB

        call        add32

        nop

        END                                     ; end program