;=============================================================================
; @(#)scheduler-test.asm  1.0  2017/05/20
;                       ________.________
;   ____   ____  ______/   __   \   ____/
;  / ___\ /  _ \/  ___/\____    /____  \ 
; / /_/  >  <_> )___ \    /    //       \
; \___  / \____/____  >  /____//______  /
;/_____/            \/                \/ 
; Copyright (c) 2017 by Alessandro Fraschetti
;
; This file is part of the xp-pic-asm project:
;     https://github.com/gos95-electronics/xp-pic-asm
; This code comes with ABSOLUTELY NO WARRANTY.
;
; Date.......: 20/05/2017
; Version....: 1.0.0
; Author.....: Alessandro Fraschetti
; Company....: gos95
; Target.....: Microchip PIC 16F6x8a Microcontroller
; Compiler...: Microchip Assembler (MPASM)
; Description:
;     Test program for scheduler library
;=============================================================================

    PROCESSOR   16f648a
    INCLUDE     "../xp-pic-asm-scheduler-library.X/src/processor.inc"
    INCLUDE     "../xp-pic-asm-scheduler-library.X/src/scheduler.inc"
    __CONFIG    _CP_OFF & _DATA_CP_OFF & _LVP_OFF & _BOREN_OFF & _MCLRE_ON & _WDT_OFF & _PWRTE_ON & _HS_OSC
;    __CONFIG   _CP_OFF & _DATA_CP_OFF & _LVP_OFF & _BOREN_OFF & _MCLRE_OFF & _WDT_OFF & _PWRTE_ON & _INTOSC_OSC_NOCLKOUT


;=============================================================================
; Variable definitions
;=============================================================================
;GPR_VAR         UDATA
;myvar1          RES         1                   ; User variable linker places

;INT_VAR         UDATA_ACS
;w_temp          RES         1                   ; w register for context saving (ACCESS)
;status_temp     RES         1                   ; status used for context saving
;pclath_temp     RES         1                   ; variable used for context saving


;=============================================================================
; Reset vector
;=============================================================================
RESET   CODE    0x0000                          ; processor reset vector
        goto    START                           ; go to beginning of program

;ISR     CODE    0x0004              ; interrupt vector location
;        MOVWF   w_temp              ; save off current W register contents
;        MOVF    STATUS, W           ; move status register into W register
;        MOVWF   status_temp         ; save off contents of STATUS register
;        MOVF    PCLATH, W           ; move pclath register into W register
;        MOVWF   pclath_temp         ; save off contents of PCLATH register
;
;        ; isr code can go here or be located as a call subroutine elsewhere
;
;        MOVF    pclath_temp, W      ; retrieve copy of PCLATH register
;        MOVWF   PCLATH              ; restore pre-isr PCLATH register contents
;        MOVF    status_temp, W      ; retrieve copy of STATUS register
;        MOVWF   STATUS              ; restore pre-isr STATUS register contents
;        SWAPF   w_temp, F
;        SWAPF   w_temp, W           ; restore pre-isr W register contents
;        RETFIE                      ; return from interrupt


;=============================================================================
; Main program
;=============================================================================
        CODE                                    ; begin program
START
        call    SCHEDULERinit
        call    SCHEDULERloop

        END                                     ; end program