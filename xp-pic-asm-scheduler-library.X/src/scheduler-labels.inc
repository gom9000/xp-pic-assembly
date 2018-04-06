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
; Target.....: Microchip Mid-Range PICmicro
; Compiler...: Microchip Assembler (MPASM)
; Version....: 1.1 2018/03/11 - source refactory
;              1.0 2017/05/20
; Description:
;  Label equates.
;=============================================================================

;----- SCREG overflow bitflags -----------------------------------------------
SC1OF               EQU     0x00                ; SCREG<0>
SC2OF               EQU     0x01                ; SCREG<1>
SC3OF               EQU     0x02                ; SCREG<2>
SC4OF               EQU     0x03                ; SCREG<3>
SC5OF               EQU     0x04                ; SCREG<4>
SC6OF               EQU     0x05                ; SCREG<5>
SC7OF               EQU     0x06                ; SCREG<6>
SC8OF               EQU     0x07                ; SCREG<7>


;----- counters init cycles --------------------------------------------------
; on 20MHz FOSC : 2ms, 10ms, 50ms, 100ms, 250ms, 500ms, 1s, 2s
SC1CYCLES           EQU     d'5'                ; 5 x timer0 cycles =   10000
SC2CYCLES           EQU     d'5'                ; 5 x SC1 cycles    =   50000
SC3CYCLES           EQU     d'5'                ; 5 x SC2 cycles    =  250000
SC4CYCLES           EQU     d'2'                ; 2 x SC3 cycles    =  500000
SC5CYCLES           EQU     d'5'                ; 5 x SC3 cycles    = 1250000
SC6CYCLES           EQU     d'2'                ; 2 x SC5 cycles    = 2500000
SC7CYCLES           EQU     d'2'                ; 2 x SC6 cycles    = 5000000
SC8CYCLES           EQU     d'2'                ; 2 x SC7 cycles    =10000000