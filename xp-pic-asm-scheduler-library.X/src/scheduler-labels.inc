;=============================================================================
; @(#)scheduler-labels.inc
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
; Version....: 1.1 2018/03/11 - source refactory
;              1.0 2017/05/20
; Description:
;  Label equates.
;=============================================================================

;----- XPSCREG overflow bitflags ---------------------------------------------
SC1OF           equ     0x00                    ; XPSCREG<0>
SC2OF           equ     0x01                    ; XPSCREG<1>
SC3OF           equ     0x02                    ; XPSCREG<2>
SC4OF           equ     0x03                    ; XPSCREG<3>
SC5OF           equ     0x04                    ; XPSCREG<4>
SC6OF           equ     0x05                    ; XPSCREG<5>
SC7OF           equ     0x06                    ; XPSCREG<6>
SC8OF           equ     0x07                    ; XPSCREG<7>


;----- counters init cycles --------------------------------------------------
;  cycles        20MHz   16MHz   10MHz   4MHz
;   10000         2ms    2.5ms    4ms    10ms
;   50000        10ms   12.5ms   20ms    50ms
;  250000        50ms   62.5ms  100ms   250ms
;  500000       100ms    125ms  200ms   500ms
; 1250000       250ms  312.5ms  500ms  1.25s
; 2500000       500ms    625ms    1s    2.5s
; 5000000         1s    1.25s     2s      5s
;10000000         2s    2.5s      4s     10s
SC1CYCLES       equ     d'5'                    ; 5 x timer0 cycles =   10000
SC2CYCLES       equ     d'5'                    ; 5 x SC1 cycles    =   50000
SC3CYCLES       equ     d'5'                    ; 5 x SC2 cycles    =  250000
SC4CYCLES       equ     d'2'                    ; 2 x SC3 cycles    =  500000
SC5CYCLES       equ     d'5'                    ; 5 x SC3 cycles    = 1250000
SC6CYCLES       equ     d'2'                    ; 2 x SC5 cycles    = 2500000
SC7CYCLES       equ     d'2'                    ; 2 x SC6 cycles    = 5000000
SC8CYCLES       equ     d'2'                    ; 2 x SC7 cycles    =10000000