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
OVERFLOW            EQU     0x00


;=============================================================================
;  VARIABLE DEFINITIONS
;=============================================================================
; Unitialized Data Section
GPR_VAR             UDATA
ARITH32REG          RES     1                   ; 32-bit arithmetic register:
                                                ; <0> overflow

var1                RES     4                   ; 32-bit variables
var2                RES     4                   ; little-endian byte ordering
var3                RES     4                   ;


;=============================================================================
;  RESET VECTOR
;=============================================================================
RESET               CODE    0x0000              ; processor reset vector
        pagesel     MAIN                        ; 
        goto        MAIN                        ; go to beginning of program


;=============================================================================
;  INIT ROUTINES
;=============================================================================
INIT_ROUTINES       CODE                        ; routines vector
init_var1
        banksel     var1
        movlw       .10 & 0xFF
        movwf       var1
        movlw       .10 >> .08 % 0xFF
        movwf       var1+1
        movlw       .10 >> .16 % 0xFF
        movwf       var1+2
        movlw       .10 >> .24 % 0xFF
        movwf       var1+3
        return

init_var2
        banksel     var2
        movlw       .13 & 0xFF
        movwf       var2
        movlw       .13 >> .08 % 0xFF
        movwf       var2+1
        movlw       .13 >> .16 % 0xFF
        movwf       var2+2
        movlw       .13 >> .24 % 0xFF
        movwf       var2+3
        return


;=============================================================================
;  MAIN PROGRAM
;=============================================================================
MAINPROGRAM         CODE                        ; begin program
MAIN
        pagesel     init_var1
        call        init_var1
        call        init_var2
        pagesel     $

add32                                           ; var3 = var1 + var2
        clrf        ARITH32REG
        movf        var2, W                     ; var3 = var2
        movwf       var3
        movf        var2+1, W
        movwf       var3+1
        movf        var2+2, W
        movwf       var3+2
        movf        var2+3, W
        movwf       var3+3

        movf        var1, W                     ; add byte 0 (LSB)
        addwf       var3, F
        movf        var1+1, W                   ; add byte 1
        btfsc       STATUS, C
        incfsz      var1+1, W
        addwf       var3+1, F
        movf        var1+2, W                   ; add byte 2
        btfsc       STATUS, C
        incfsz      var1+2, W
        addwf       var3+2, F
        movf        var1+3, W                   ; add byte 3 (MSB)
        btfsc       STATUS, C
        incfsz      var1+3, W
        addwf       var3+3, F
        btfsc       STATUS, C
        bsf         ARITH32REG, OVERFLOW

        nop

        pagesel     init_var1
        call        init_var1
        call        init_var2
        pagesel     $

sub32                                           ; var3 = var2 - var1
        clrf        ARITH32REG
        movf        var2, W                     ; var3 = var2
        movwf       var3
        movf        var2+1, W
        movwf       var3+1
        movf        var2+2, W
        movwf       var3+2
        movf        var2+3, W
        movwf       var3+3

        movf        var1, W                     ; sub byte 0 (LSB)
        subwf       var3, F
        movf        var1+1, W                   ; sub byte 1
        btfss       STATUS, C
        incfsz      var1+1, W
        subwf       var3+1, F
        movf        var1+2, W                   ; sub byte 2
        btfss       STATUS, C
        incfsz      var1+2, W
        subwf       var3+2, F
        movf        var1+3, W                   ; sub byte 3 (MSB)
        btfss       STATUS, C
        incfsz      var1+3, W
        subwf       var3+3, F
        btfsc       STATUS, C
;        bsf         ARITH32REG, OVERFLOW

        nop

        END                                     ; end program