;=============================================================================
; @(#)scheduler-init.asm
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
;
; Module.....: SCHEDULERloop
; Description: Execute the scheduler main loop
;=============================================================================

        TITLE       'SCHEDULERloop - The scheduler main loop'
        SUBTITLE    'Part of the xp-pic-asm-scheduler-library'


        INCLUDE     processor.inc
        INCLUDE     scheduler-labels.inc


        GLOBAL      SCHEDULERloop
        EXTERN      xpsc1of_action
        EXTERN      xpsc2of_action
        EXTERN      xpsc3of_action
        EXTERN      xpsc4of_action
        EXTERN      xpsc5of_action
        EXTERN      xpsc6of_action
        EXTERN      xpsc7of_action
        EXTERN      xpsc8of_action
        EXTERN      XPSCREG
        EXTERN      sc1Counter
        EXTERN      sc2Counter
        EXTERN      sc3Counter
        EXTERN      sc4Counter
        EXTERN      sc5Counter
        EXTERN      sc6Counter
        EXTERN      sc7Counter
        EXTERN      sc8Counter


;=============================================================================
; Module
;=============================================================================
        CODE                                    ; begin module
SCHEDULERloop

mainloop
        btfss       INTCON, T0IF                ; timer overflow?
        goto        mainloop                    ; no  : loop!

        bcf         INTCON, T0IF                ; yes : reset overflow flag
        movlw       7                           ; and reset TMR0 to overflow every
        movwf       TMR0                        ; 250*8 cycles (400uS on 20MHz FOSC)
                                                ; (256 - 250 + 3)


; --  manage sc1-period tasks ------------------------------------------------
begin_sc1tasks
        btfss       XPSCREG, SC1OF              ; SC1 timer overflow?
        goto        end_sc1tasks                ; not time yet
        nop
        nop
        call        xpsc1of_action              ; yes, execute tasks
end_sc1tasks
; ----------------------------------------------------------------------------


; --  manage sc2-period tasks ------------------------------------------------
begin_sc2tasks
        btfss       XPSCREG, SC2OF              ; SC2 timer overflow?
        goto        end_sc2tasks                ; not time yet
        nop
        nop
        call        xpsc2of_action              ; yes, execute tasks
end_sc2tasks
; ----------------------------------------------------------------------------


; --  manage sc3-period tasks ------------------------------------------------
begin_sc3tasks
        btfss       XPSCREG, SC3OF              ; SC3 timer overflow?
        goto        end_sc3tasks                ; not time yet
        nop
        nop
        call        xpsc3of_action              ; yes, execute tasks
end_sc3tasks
; ----------------------------------------------------------------------------


; --  manage sc4-period tasks ------------------------------------------------
begin_sc4tasks
        btfss       XPSCREG, SC4OF              ; SC4 timer overflow?
        goto        end_sc4tasks                ; not time yet
        nop
        nop
        call        xpsc4of_action              ; yes, execute tasks
end_sc4tasks
; ----------------------------------------------------------------------------


; --  manage sc5-period tasks ------------------------------------------------
begin_sc5tasks
        btfss       XPSCREG, SC5OF              ; SC5 timer overflow?
        goto        end_sc5tasks                ; not time yet
        nop
        nop
        call        xpsc5of_action              ; yes, execute tasks
end_sc5tasks
; ----------------------------------------------------------------------------


; --  manage sc6-period tasks ------------------------------------------------
begin_sc6tasks
        btfss       XPSCREG, SC6OF              ; SC6 timer overflow?
        goto        end_sc6tasks                ; not time yet
        nop
        nop
        call        xpsc6of_action              ; yes, execute tasks
end_sc6tasks
; ----------------------------------------------------------------------------


; --  manage sc7-period tasks ------------------------------------------------
begin_sc7tasks
        btfss       XPSCREG, SC7OF              ; SC7 timer overflow?
        goto        end_sc7tasks                ; not time yet
        nop
        nop
        call        xpsc7of_action              ; yes, execute tasks
end_sc7tasks
; ----------------------------------------------------------------------------


; --  manage sc8-period tasks ------------------------------------------------
begin_sc8tasks
        btfss       XPSCREG, SC8OF              ; SC8 timer overflow?
        goto        end_sc8tasks                ; not time yet
        nop
        nop
        call        xpsc8of_action              ; yes, execute tasks
end_sc8tasks
; ----------------------------------------------------------------------------


; --  scheduler counters business --------------------------------------------
begin_scheduler_business
        clrf        XPSCREG                     ; reset scheduler register
sc1test
        decfsz      sc1Counter, F               ; countdown and test sc1 counter
        goto        end_scheduler_business      ; not time yet
        movlw       SC1CYCLES                   ; yes, reset counter
        movwf       sc1Counter
        bsf         XPSCREG, SC1OF              ; and set bitflag
        nop
sc2test
        decfsz      sc2Counter, F               ; countdown and test sc2 counter
        goto        end_scheduler_business      ; not time yet
        movlw       SC2CYCLES                   ; yes, reset counter
        movwf       sc2Counter
        bsf         XPSCREG, SC2OF              ; and set bitflag
        nop
sc3test
        decfsz      sc3Counter, F               ; countdown and test sc3 counter
        goto        end_scheduler_business      ; not time yet
        movlw       SC3CYCLES                   ; yes, reset counter
        movwf       sc3Counter
        bsf         XPSCREG, SC3OF              ; and set bitflag
        nop
sc4test
        decfsz      sc4Counter, F               ; countdown and test sc4 counter
        goto        sc5test                     ; not time yet
        movlw       SC4CYCLES                   ; yes, reset counter
        movwf       sc4Counter
        bsf         XPSCREG, SC4OF              ; and set bitflag
        nop
sc5test
        decfsz      sc5Counter, F               ; countdown and test sc5 counter
        goto        end_scheduler_business      ; not time yet
        movlw       SC5CYCLES                   ; yes, reset counter
        movwf       sc5Counter
        bsf         XPSCREG, SC5OF              ; and set bitflag
        nop
sc6test
        decfsz      sc6Counter, F               ; countdown and test sc6 counter
        goto        end_scheduler_business      ; not time yet
        movlw       SC6CYCLES                   ; yes, reset counter
        movwf       sc6Counter
        bsf         XPSCREG, SC6OF              ; and set bitflag
        nop
sc7test
        decfsz      sc7Counter, F               ; countdown and test sc7 counter
        goto        end_scheduler_business      ; not time yet
        movlw       SC7CYCLES                   ; yes, reset counter
        movwf       sc7Counter
        bsf         XPSCREG, SC7OF              ; and set bitflag
        nop
sc8test
        decfsz      sc8Counter, F               ; countdown and test sc8 counter
        goto        end_scheduler_business      ; not time yet
        movlw       SC8CYCLES                   ; yes, reset counter
        movwf       sc8Counter
        bsf         XPSCREG, SC8OF              ; and set bitflag
        nop
end_scheduler_business
; ----------------------------------------------------------------------------

endmainloop
        goto        mainloop

        return

        END                                     ; end module