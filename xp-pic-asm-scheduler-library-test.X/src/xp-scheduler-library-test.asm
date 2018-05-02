;=============================================================================
; @(#)xp-scheduler-library-test.asm
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
; Target.....: Microchip MidRange PICmicro
; Compiler...: Microchip Assembler (MPASM)
; Version....: 1.1 2018/03/11 - source refactory
;              1.0 2017/05/20
; Description: Test program for xp-scheduler library
;=============================================================================

    PROCESSOR   16f648a
    INCLUDE     <p16f648a.inc>
    INCLUDE     "../xp-pic-asm-scheduler-library.X/src/processor.inc"
    INCLUDE     "../xp-pic-asm-scheduler-library.X/src/xp-scheduler-library.inc"

    GLOBAL      task_2ms_action
    GLOBAL      task_10ms_action
    GLOBAL      task_50ms_action
    GLOBAL      task_100ms_action
    GLOBAL      task_250ms_action
    GLOBAL      task_500ms_action
    GLOBAL      task_1s_action
    GLOBAL      task_2s_action


;=============================================================================
;  CONFIGURATION
;=============================================================================
    __CONFIG    _CP_OFF & _DATA_CP_OFF & _LVP_OFF & _BOREN_OFF & _MCLRE_ON & _WDT_OFF & _PWRTE_ON & _HS_OSC


;=============================================================================
;  RESET VECTOR
;=============================================================================
RESET               CODE    0x0000              ; processor reset vector
        pagesel     MAIN                        ; 
        goto        MAIN                        ; go to beginning of program


;=============================================================================
;  TASK IMPLEMENTATIONS
;=============================================================================
TASK_IMP            CODE                        ; begin module
task_2ms_action
        nop
        return
        
task_10ms_action
        nop
        return
        
task_50ms_action
        nop
        return

task_100ms_action
        nop
        return

task_250ms_action
        nop
        return

task_500ms_action
        nop
        return

task_1s_action
        nop
        return

task_2s_action
        nop
        return


;=============================================================================
;  MAIN PROGRAM
;=============================================================================
MAINPROGRAM         CODE                        ; begin program
MAIN
        call    SCHEDULERinit
        call    SCHEDULERloop

        END                                     ; end program