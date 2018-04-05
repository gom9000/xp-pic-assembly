;=============================================================================
; @(#)xp-io-digital-array.asm
;                       ________.________
;   ____   ____  ______/   __   \   ____/
;  / ___\ /  _ \/  ___/\____    /____  \ 
; / /_/  >  <_> )___ \    /    //       \
; \___  / \____/____  >  /____//______  /
;/_____/            \/                \/ 
; Copyright (c) 2014 by Alessandro Fraschetti (gos95@gommagomma.net).
;
; This file is part of the xp-pic-asm project:
;     https://github.com/gos95-electronics/xp-pic-asm
; This code comes with ABSOLUTELY NO WARRANTY.
;
; Author.....: Alessandro Fraschetti
; Company....: gos95
; Target.....: Microchip PIC 16F628a Microcontroller
; Compiler...: Microchip Assembler (MPASM)
; Version....: 1.1 2018/03/13 - source refactory
;              1.0 2014/04/08
; Description: Software management of switch and led arrays.
;=============================================================================

    PROCESSOR   16f648a
    INCLUDE     <p16f648a.inc>


;=============================================================================
;  CONFIGURATION
;=============================================================================
    __CONFIG    _CP_OFF & _DATA_CP_OFF & _LVP_OFF & _BOREN_OFF & _MCLRE_ON & _WDT_OFF & _PWRTE_ON & _HS_OSC


;=============================================================================
;  Label equates
;=============================================================================
SWITCH          equ     PORTB
SW1             equ     0x00
SW2             equ     0x01
SW3             equ     0x02
SW4             equ     0x03

LED             equ     PORTA
LED1            equ     0x00
LED2            equ     0x01
LED3            equ     0x02
LED4            equ     0x03

XP_SWA_SIZE     equ     0x04
XP_SWA_SAMPLES  equ     0x05
XP_SWA_CLICKED  equ     0x00
XP_SWA_STATUS   equ     0x07


;=============================================================================
;  File register use
;=============================================================================
    cblock	h'20'
        w_temp                          ; variable used for context saving
        status_temp                     ; variable used for context saving
        pclath_temp                     ; variable used for context saving

        d1, d2, d3                      ; the delay routine vars

        xp_swa_index

        ; switch-pressed samples counter
        xp_swa_samples_counter: XP_SWA_SIZE

        ; <7> single-click last stable status flag
        ; <0> single-click status change flag
        XP_SWA_REG: XP_SWA_SIZE+1

        xp_swa_mask: XP_SWA_SIZE
    endc


;=============================================================================
;  Start of code
;=============================================================================
;start
        org         h'0000'             ; processor reset vector
        goto        main                ; jump to the main routine

        org         h'0004'             ; interrupt vector location
        movwf       w_temp              ; save off current W register contents
        movf        STATUS, W           ; move status register into W register
        movwf       status_temp         ; save off contents of STATUS register
        movf        PCLATH, W           ; move pclath register into W register
        movwf       pclath_temp         ; save off contents of PCLATH register

        ; isr code can go here or be located as a call subroutine elsewhere

        movf        pclath_temp, W      ; retrieve copy of PCLATH register
        movwf       PCLATH              ; restore pre-isr PCLATH register contents
        movf        status_temp, W      ; retrieve copy of STATUS register
        movwf       STATUS              ; restore pre-isr STATUS register contents
        swapf       w_temp, F
        swapf       w_temp, W           ; restore pre-isr W register contents
        retfie                          ; return from interrupt


;=============================================================================
;  Init I/O ports
;=============================================================================
init_ports

        errorlevel	-302

        ; set PORTA JA1(A0-A3) as Output
        bcf         STATUS, RP0             ; select Bank0
        clrf        PORTA                   ; initialize PORTB by clearing output data latches
        movlw       h'07'                   ; turn comparators off
        movwf       CMCON                   ; and set port A mode I/O digital
        bsf         STATUS, RP0             ; select Bank1
        movlw       b'11100000'             ; PORTA input/output
  		movwf       TRISA

        ; set JB1 (B0-B3) as Input
        bcf         STATUS, RP0             ; select Bank0
        clrf        PORTB                   ; initialize PORTB by clearing output data latches
        bsf         STATUS, RP0             ; select Bank1
        movlw       b'00001111'             ; PORTB input/output
        movwf       TRISB
        clrf        STATUS                  ; select Bank0

        errorlevel  +302

        return


;=============================================================================
;  delay routines
;=============================================================================

;  1ms delay routine (20MHz)
delay1ms
        movlw       0xE6                    ;4993 cycles
        movwf       d1
        movlw       0x04
        movwf       d2
delay1ms_loop
        decfsz      d1, F
        goto        $+2
        decfsz      d2, F
        goto        delay1ms_loop
        goto        $+1                     ;3 cycles
        nop

        return                              ;4 cycles (including call)


;=============================================================================
;  switch-array management routines
;=============================================================================
xp_swa_init
        movlw       b'00000001'
        movwf       xp_swa_index
    variable ii=0
    while ii < XP_SWA_SIZE
        movlw       XP_SWA_SAMPLES
        movwf       xp_swa_samples_counter+ii
        clrf        XP_SWA_REG+ii

        movf        xp_swa_index, W
        movwf       xp_swa_mask+ii
        rlf         xp_swa_index, F
ii+=1
    endw
        clrf        xp_swa_index
        return

xp_swa_scan
        movwf       xp_swa_index                ; get the sw-index value from W

        addlw       XP_SWA_REG+1                ; add the index to the base address of XP_SWA_REG + 1
        movwf       FSR                         ; load FSR with base address + offset
        bcf         INDF, XP_SWA_CLICKED        ; use INDF to point to XP_SWA_REG[index] 
        bcf         XP_SWA_REG, XP_SWA_CLICKED

        movf        xp_swa_index, W
        addlw       xp_swa_mask
        movwf       FSR
        movf        SWITCH, W
        andwf       INDF, W
        btfss       STATUS, Z
        goto        swa_reset

        movf        xp_swa_index, W
        addlw       xp_swa_samples_counter
        movwf       FSR
        decfsz      INDF
        return
        movf        xp_swa_index, W
        addlw       XP_SWA_REG+1
        movwf       FSR
        btfsc       INDF, XP_SWA_STATUS
        return
        bsf         INDF, XP_SWA_STATUS
swa_action
        bsf         INDF, XP_SWA_CLICKED
        bsf         XP_SWA_REG, XP_SWA_CLICKED
        return
swa_reset
        movf        xp_swa_index, W
        addlw       xp_swa_samples_counter
        movwf       FSR
        movlw       XP_SWA_SAMPLES
        movwf       INDF

        movf        xp_swa_index, W
        addlw       XP_SWA_REG+1
        movwf       FSR
        bcf         INDF, XP_SWA_STATUS
        return


;=============================================================================
;  Main program
;=============================================================================
main
        call        init_ports

        bcf         LED, LED1
        bcf         LED, LED2
        bcf         LED, LED3
        bcf         LED, LED4

        call        xp_swa_init
mainloop

switch_1_control
        movlw       SW1
        call        xp_swa_scan

        btfss       XP_SWA_REG, XP_SWA_CLICKED
        goto        switch_2_control
        btfsc       LED, LED1
        goto        $+3
        bsf         LED, LED1
        goto        switch_2_control
        bcf         LED, LED1


switch_2_control
        movlw       SW2
        call        xp_swa_scan

        btfss       XP_SWA_REG, XP_SWA_CLICKED
        goto        switch_3_control
        btfsc       LED, LED2
        goto        $+3
        bsf         LED, LED2
        goto        switch_3_control
        bcf         LED, LED2


switch_3_control
        movlw       SW3
        call        xp_swa_scan

        btfss       XP_SWA_REG, XP_SWA_CLICKED
        goto        switch_4_control
        btfsc       LED, LED3
        goto        $+3
        bsf         LED, LED3
        goto        switch_4_control
        bcf         LED, LED3


switch_4_control ; momentary toggling switch with sampling debounce tecnique
        movlw       SW4
        call        xp_swa_scan

        btfss       XP_SWA_REG, XP_SWA_CLICKED
        goto        end_sw_controls
        btfsc       LED, LED4
        goto        $+3
        bsf         LED, LED4
        goto        end_sw_controls
        bcf         LED, LED4


end_sw_controls
        call        delay1ms
        goto        mainloop

        end