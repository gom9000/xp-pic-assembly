;=============================================================================
; @(#)xp-io-digital-array.asm
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
; Target.....: Microchip PICmicro 16F648a Microcontroller
; Compiler...: Microchip Assembler (MPASM)
; Version....: 1.1 2018/03/13 - source refactory
;              1.0 2017/04/08
; Description: Software management of switch and led arrays.
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
SWITCH              EQU     PORTB
SW1                 EQU     0x00
SW2                 EQU     0x01
SW3                 EQU     0x02
SW4                 EQU     0x03

LED                 EQU     PORTA
LED1                EQU     0x00
LED2                EQU     0x01
LED3                EQU     0x02
LED4                EQU     0x03

XP_SWA_SIZE         EQU     0x04
XP_SWA_SAMPLES      EQU     0x05
XP_SWA_CLICKED      EQU     0x00
XP_SWA_STATUS       EQU     0x07


;=============================================================================
;  VARIABLE DEFINITIONS
;=============================================================================
DELAY_VAR           UDATA
d1                  RES     1                   ; the delay routine vars
d2                  RES     1                   ;
d3                  RES     1                   ;

XPSWA_VAR           UDATA
xp_swa_shadow_port  RES     1
xp_swa_index        RES     1
xp_swa_samples_cnt  RES     XP_SWA_SIZE         ; switch-pressed samples counter
xp_swa_register     RES     XP_SWA_SIZE         ; <7> single-click last stable status flag
                                                ; <0> single-click status change flag
xp_swa_mask         RES     XP_SWA_SIZE

XPSWA_SHR_VAR       UDATA_SHR
XP_SWA_REG          RES     1                   ; <7> single-click last stable status flag
                                                ; <0> single-click status change flag
XPLDA_VAR           UDATA
xp_lda_shadow_port  RES     1


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
init_ports                                      ; init I/O ports
        errorlevel  -302

        ; set PORTA JA1(A0-A3) as Output
        banksel     PORTA
        clrf        PORTA                       ; initialize PORTB by clearing output data latches
        movlw       h'07'                       ; turn comparators off
        movwf       CMCON                       ; and set port A mode I/O digital
        banksel     TRISA
        movlw       b'11100000'                 ; PORTA input/output
  		movwf		TRISA

        ; set JB1 (B0-B3) as Input
        banksel     PORTB
        clrf        PORTB                       ; initialize PORTB by clearing output data latches
        banksel     TRISB
        movlw       b'00001111'                 ; PORTB input/output
        movwf		TRISB

        errorlevel  +302

        return


;=============================================================================
;  DELAY ROUTINES
;=============================================================================
DELAY_ROUTINES      CODE                        ; delay routines vector
delay1ms                                        ; 1ms delay routine (20MHz)
        banksel     d1                          ; point to DELAY_VAR section
        movlw       0xE6                        ; 4993 cycles
        movwf       d1
        movlw       0x04
        movwf       d2
delay1ms_loop
        decfsz      d1, F
        goto        $+2
        decfsz      d2, F
        goto        delay1ms_loop
        goto        $+1                         ; 3 cycles
        nop

        return                                  ; 4 cycles (including call)


;=============================================================================
;  SWITCHARRAY ROUTINES
;  momentary toggling switch with sampling debounce tecnique
;=============================================================================
XPSWA_ROUTINES      CODE                        ; swa routines vector
xp_swa_init
        banksel     xp_swa_shadow_port          ; point to XPSWA_VAR section
        clrf        xp_swa_shadow_port
        movlw       b'00000001'
        movwf       xp_swa_index
    variable ii=0
    while ii < XP_SWA_SIZE
        movlw       XP_SWA_SAMPLES
        movwf       xp_swa_samples_cnt+ii
        clrf        xp_swa_register+ii

        movf        xp_swa_index, W
        movwf       xp_swa_mask+ii
        rlf         xp_swa_index, F
ii+=1
    endw
        clrf        xp_swa_index
        return

;
xp_swa_shadow_swaport
        banksel     xp_swa_shadow_port
        movwf       xp_swa_shadow_port
        return

;
xp_swa_scan
        banksel     xp_swa_index                ; point to XPSWA_VAR section
        movwf       xp_swa_index                ; get the sw-index value from W

        addlw       xp_swa_register             ; add the index to the base address of xp_swa_register
        movwf       FSR                         ; load FSR with base address + offset
        bcf         INDF, XP_SWA_CLICKED        ; use INDF to point to xp_swa_register[index] 
        bcf         XP_SWA_REG, XP_SWA_CLICKED

        movf        xp_swa_index, W
        addlw       xp_swa_mask
        movwf       FSR
        movf        xp_swa_shadow_port, W
        andwf       INDF, W
        btfss       STATUS, Z
        goto        swa_reset

        movf        xp_swa_index, W
        addlw       xp_swa_samples_cnt
        movwf       FSR
        decfsz      INDF, F
        return
        movf        xp_swa_index, W
        addlw       xp_swa_register
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
        addlw       xp_swa_samples_cnt
        movwf       FSR
        movlw       XP_SWA_SAMPLES
        movwf       INDF

        movf        xp_swa_index, W
        addlw       xp_swa_register
        movwf       FSR
        bcf         INDF, XP_SWA_STATUS
        return


;=============================================================================
;  MAIN PROGRAM
;=============================================================================
MAINPROGRAM         CODE                        ; begin program
MAIN
        lcall       init_ports
        lcall       xp_swa_init
        pagesel     $

        banksel     LED                         ; shadowing of LED port reg
        movf        LED, W
        banksel     xp_lda_shadow_port
        movwf       xp_lda_shadow_port

mainloop
        banksel     SWITCH
        movf        SWITCH, W
        lcall       xp_swa_shadow_swaport
        pagesel     $

switch_1_control
        movlw       SW1
        lcall       xp_swa_scan
        pagesel     $

        banksel     LED
        btfss       XP_SWA_REG, XP_SWA_CLICKED
        goto        switch_2_control
        btfsc       LED, LED1
        goto        $+3
        bsf         LED, LED1
        goto        switch_2_control
        bcf         LED, LED1

switch_2_control
        movlw       SW2
        lcall       xp_swa_scan
        pagesel     $

        banksel     LED
        btfss       XP_SWA_REG, XP_SWA_CLICKED
        goto        switch_3_control
        btfsc       LED, LED2
        goto        $+3
        bsf         LED, LED2
        goto        switch_3_control
        bcf         LED, LED2

switch_3_control
        movlw       SW3
        lcall       xp_swa_scan
        pagesel     $

        banksel     LED
        btfss       XP_SWA_REG, XP_SWA_CLICKED
        goto        switch_4_control
        btfsc       LED, LED3
        goto        $+3
        bsf         LED, LED3
        goto        switch_4_control
        bcf         LED, LED3

switch_4_control
        movlw       SW4
        lcall       xp_swa_scan
        pagesel     $

        banksel     LED
        btfss       XP_SWA_REG, XP_SWA_CLICKED
        goto        end_sw_controls
        btfsc       LED, LED4
        goto        $+3
        bsf         LED, LED4
        goto        end_sw_controls
        bcf         LED, LED4

end_sw_controls
        lcall       delay1ms
        pagesel     $
        goto        mainloop

        END                                     ; end program