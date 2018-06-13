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
; Target.....: Microchip PICmicro MidRange Microcontroller
; Compiler...: Microchip Assembler (MPASM)
; Version....: 1.0 2018/04/11
; Description: 32-bit (quadruple) integer arithmetic
;=============================================================================

    PROCESSOR   16f648a
    INCLUDE     <p16f648a.inc>


;=============================================================================
;  CONFIGURATION
;=============================================================================
    __CONFIG    _CP_OFF & _DATA_CP_OFF & _LVP_OFF & _BOREN_OFF & _MCLRE_ON & _WDT_OFF & _PWRTE_ON & _HS_OSC


;=============================================================================
;  CONSTANT DEFINITIONS
;=============================================================================
    constant    CF = 0x0
    constant    SF = 0x1
    constant    OF = 0x2

    constant    ACCASF = 0x4
    constant    ACCBSF = 0x5


;=============================================================================
;  32-BIT PRECISION VARIABLE DEFINITIONS
;=============================================================================
GPR_DATA            UDATA
var1                RES     4                   ; 32-bit variables
var2                RES     4                   ;


;=============================================================================
;  32-BIT PRECISION INTEGER ARITHMETIC VARIABLE DEFINITIONS
;=============================================================================
INT32_DATA          UDATA
STATUS32            RES     1                   ; 32-bit arithmetic status register:
                                                ; <0> carry out flag
                                                ; <1> sign flag : H = +, L = -
                                                ; <2> overflow flag
                                                ; <4> accA sign flag
                                                ; <5> accB sign flag

accA                RES     4                   ; 32-bit accumulators
accB                RES     4                   ; little-endian byte ordering
accC                RES     4                   ;
acc8                RES     1


;=============================================================================
;  RESET VECTOR
;=============================================================================
RESET               CODE    0x0000              ; processor reset vector
        pagesel     MAIN                        ; 
        goto        MAIN                        ; go to beginning of program


;=============================================================================
;  32-BIT PRECISION INTEGER ARITHMETIC ROUTINE VECTOR
;=============================================================================
INT32_CODE          CODE

;*************************************************************************
; Load 32-bit value to accA
; Value LSB-address in W
;*************************************************************************
load_accA
        banksel     accA
        movwf       acc8

        movwf       FSR                         ; copy byte 0
        movf        INDF, W
        movwf       accA

        movf        acc8, W                     ; copy byte 1
        incf        acc8, F
        movf        acc8, W
        movwf       FSR
        movf        INDF, W
        movwf       accA+1

        movf        acc8, W                     ; copy byte 2
        incf        acc8, F
        movf        acc8, W
        movwf       FSR
        movf        INDF, W
        movwf       accA+2

        movf        acc8, W                     ; copy byte 3
        incf        acc8, F
        movf        acc8, W
        movwf       FSR
        movf        INDF, W
        movwf       accA+3

        bcf         STATUS32, ACCASF            ; set accA SF
        btfsc       accA+3, 7
        bsf         STATUS32, ACCASF

        return

;*************************************************************************
; Load 32-bit value to accB
; Value LSB-address in W
;*************************************************************************
load_accB
        banksel     accB
        movwf       acc8

        movwf       FSR                         ; copy byte 0
        movf        INDF, W
        movwf       accB

        movf        acc8, W                     ; copy byte 1
        incf        acc8, F
        movf        acc8, W
        movwf       FSR
        movf        INDF, W
        movwf       accB+1

        movf        acc8, W                     ; copy byte 2
        incf        acc8, F
        movf        acc8, W
        movwf       FSR
        movf        INDF, W
        movwf       accB+2

        movf        acc8, W                     ; copy byte 3
        incf        acc8, F
        movf        acc8, W
        movwf       FSR
        movf        INDF, W
        movwf       accB+3

        bcf         STATUS32, ACCBSF            ; set accB SF
        btfsc       accB+3, 7
        bsf         STATUS32, ACCBSF

        return

;*************************************************************************
; 32-bit Precision Negating (twos complement notation): accB(32-bit) = -accB(32-bit)
;*************************************************************************
negate_accA
        banksel     accA
        comf        accA, F                     ; 1 complement of bytes
        comf        accA+1, F
        comf        accA+2, F
        comf        accA+3, F
        incf        accA, F                     ; add 1
        btfss       STATUS, Z
        return
        incf        accA+1, F
        btfss       STATUS, Z
        return
        incf        accA+2, F
        btfss       STATUS, Z
        return
        incf        accA+3, F

        return

negate_accB
        banksel     accB
        comf        accB, F                     ; 1 complement of bytes
        comf        accB+1, F
        comf        accB+2, F
        comf        accB+3, F
        incf        accB, F                     ; add 1
        btfss       STATUS, Z
        return
        incf        accB+1, F
        btfss       STATUS, Z
        return
        incf        accB+2, F
        btfss       STATUS, Z
        return
        incf        accB+3, F

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
        incfsz      accB+1, W                   ; add carry into byte 2
        addwf       accA+1, F
        movf        accB+2, W                   ; add byte 2
        btfsc       STATUS, C
        incfsz      accB+2, W
        addwf       accA+2, F
        movf        accB+3, W                   ; add byte 3 (MSB)
        btfsc       STATUS, C
        incfsz      accB+3, W
        addwf       accA+3, F

        btfsc       STATUS, C                   ; update CF
        bsf         STATUS32, CF
        banksel     accA
        btfsc       accA+3, 7                   ; update SF
        bsf         STATUS32, SF

        btfsc       STATUS32, ACCASF            ; update OF (ACCASF=0 & ACCBSF=0 & SF=1)
        goto        addtestOF110
        btfsc       STATUS32, ACCBSF
        goto        addtestOF110
        btfsc       STATUS32, SF
        bsf         STATUS32, OF
addtestOF110
        btfss       STATUS32, ACCASF            ; update OF (ACCASF=1 & ACCBSF=1 & SF=0)
        goto        addendtestOF
        btfss       STATUS32, ACCBSF
        goto        addendtestOF
        btfss       STATUS32, SF
        bsf         STATUS32, OF
addendtestOF
        bcf         STATUS32, ACCASF            ; update accA SF
        btfsc       accA+3, 7
        bsf         STATUS32, ACCASF

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

        movf        accB, W                     ; sub byte 0 (LSB)
        subwf       accA, F
        movf        accB+1, W                   ; sub byte 1
        btfss       STATUS, C
        incfsz      accB+1, W
        subwf       accA+1, F
        movf        accB+2, W                   ; sub byte 2
        btfss       STATUS, C
        incfsz      accB+2, W
        subwf       accA+2, F
        movf        accB+3, W                   ; sub byte 3 (MSB)
        btfss       STATUS, C
        incfsz      accB+3, W
        subwf       accA+3, F

        btfsc       STATUS, C                   ; set CF
        bsf         STATUS32, CF
        banksel     accA
        btfsc       accA+3, 7                   ; update SF
        bsf         STATUS32, SF

        btfsc       STATUS32, ACCASF            ; update OF (ACCASF=0 & ACCBSF=1 & SF=1)
        goto        subtestOF110
        btfss       STATUS32, ACCBSF
        goto        subtestOF110
        btfsc       STATUS32, SF
        bsf         STATUS32, OF
subtestOF110
        btfss       STATUS32, ACCASF            ; update OF (ACCASF=1 & ACCBSF=0 & SF=0)
        goto        subendtestOF
        btfsc       STATUS32, ACCBSF
        goto        subendtestOF
        btfss       STATUS32, SF
        bsf         STATUS32, OF
subendtestOF
        bcf         STATUS32, ACCASF            ; update accA SF
        btfsc       accA+3, 7
        bsf         STATUS32, ACCASF

        return


;=============================================================================
;  MAIN PROGRAM
;=============================================================================
MAINPROGRAM         CODE                        ; begin program
MAIN
        banksel     var1
        movlw       .127 & 0xFF
        movwf       var1
        movlw       .127 >> .08 % 0xFF
        movwf       var1+1
        movlw       .127 >> .16 % 0xFF
        movwf       var1+2
        movlw       .127 >> .24 % 0xFF
        movwf       var1+3

        movlw       .126 & 0xFF
        movwf       var2
        movlw       .126 >> .08 % 0xFF
        movwf       var2+1
        movlw       .126 >> .16 % 0xFF
        movwf       var2+2
        movlw       .126 >> .24 % 0xFF
        movwf       var2+3


        banksel     var1
        movlw       var1
        pagesel     load_accA
        call        load_accA

        banksel     var2
        movlw       var2
        pagesel     load_accB
        call        load_accB

        call        negate_accB
        call        add32

        nop

        END                                     ; end program