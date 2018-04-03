;=============================================================================
; @(#)filename.asm
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
; Target.....: Microchip PICmicro #pic_model# Microcontroller
; Compiler...: Microchip Assembler (MPASM)
; Version....: #x.y# #release_date# - #whatsnew#
;              #x.y# #release_date# - #whatsnew#
;
; Module.....: #module_name#
; Description: #module description#
;=============================================================================

        TITLE       'module_name - Initialize the scheduler'
        SUBTITLE    'Part of the xp-pic-asm-xxx-library'

;        INCLUDE     library_name-labels.inc

        GLOBAL      module_name
        GLOBAL      vstuff


;=============================================================================
;  VARIABLE DEFINITIONS
;=============================================================================
; Unitialized Data Section
GPR_MODULE_VAR  UDATA
vstuff          RES     1                       ; variable used for stuff...


;=============================================================================
;  MODULE PROGRAM
;=============================================================================
MODULE          CODE                            ; begin module
module_name
        nop

        END                                     ; end module