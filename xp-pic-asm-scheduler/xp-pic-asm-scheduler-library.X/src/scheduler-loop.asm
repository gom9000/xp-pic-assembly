;=============================================================================
; @(#)scheduler-init.asm
;                       ________.________
;   ____   ____  ______/   __   \   ____/
;  / ___\ /  _ \/  ___/\____    /____  \ 
; / /_/  >  <_> )___ \    /    //       \
; \___  / \____/____  >  /____//______  /
;/_____/            \/                \/ 
; Copyright (c) 2017 Alessandro Fraschetti (gos95@gommagomma.net).
;
; This file is part of the pic-assembly-xp project:
;     https://github.com/pic-assembly-xp
;
; Author.....: Alessandro Fraschetti
; Company....: gos95
; Target.....: Microchip Mid-Range PICmicro
; Compiler...: Microchip Assembler (MPASM)
; Version....: 1.1 2018/03/11 - source refactory
;              1.0 2017/05/20
;
; Module.....: SCHEDULERloop
; Description: Execute the scheduler main loop
;=============================================================================
; Permission is hereby granted, free of charge, to any person obtaining a copy
; of this software and associated documentation files (the "Software"), to deal
; in the Software without restriction, including without limitation the rights
; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
; copies of the Software, and to permit persons to whom the Software is
; furnished to do so, subject to the following conditions:

; The above copyright notice and this permission notice shall be included in all
; copies or substantial portions of the Software.

; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
; SOFTWARE.
;=============================================================================


    TITLE       'SCHEDULERloop - The scheduler main loop'
    SUBTITLE    'Part of the xp-pic-asm-scheduler-library'

    INCLUDE     processor.inc
    INCLUDE     scheduler-labels.inc

    GLOBAL      SCHEDULERloop

    EXTERN      task_2ms_action
    EXTERN      task_10ms_action
    EXTERN      task_50ms_action
    EXTERN      task_100ms_action
    EXTERN      task_250ms_action
    EXTERN      task_500ms_action
    EXTERN      task_1s_action
    EXTERN      task_2s_action
    EXTERN      SCREG
    EXTERN      sc1Counter
    EXTERN      sc2Counter
    EXTERN      sc3Counter
    EXTERN      sc4Counter
    EXTERN      sc5Counter
    EXTERN      sc6Counter
    EXTERN      sc7Counter
    EXTERN      sc8Counter


;=============================================================================
;  MODULE PROGRAM
;=============================================================================
XP_SCHEDULER_LOOP   CODE                        ; begin module
SCHEDULERloop
        clrf        STATUS                      ; select Bank0

mainloop
        btfss       INTCON, T0IF                ; timer overflow?
        goto        mainloop                    ; no  : loop!

        bcf         INTCON, T0IF                ; yes : reset overflow flag
        movlw       7                           ; and reset TMR0 to overflow every
        movwf       TMR0                        ; 250*8 cycles (400uS on 20MHz FOSC)
                                                ; (256 - 250 + 3)

; --  manage sc1-period tasks ------------------------------------------------
begin_sc1tasks
        btfss       SCREG, SC1OF                ; SC1 timer overflow?
        goto        end_sc1tasks                ; not time yet
        nop
        nop
        pagesel     task_2ms_action
        call        task_2ms_action             ; yes, execute tasks
        pagesel     $
end_sc1tasks
; ----------------------------------------------------------------------------


; --  manage sc2-period tasks ------------------------------------------------
begin_sc2tasks
        btfss       SCREG, SC2OF                ; SC2 timer overflow?
        goto        end_sc2tasks                ; not time yet
        nop
        nop
        pagesel     task_10ms_action
        call        task_10ms_action            ; yes, execute tasks
        pagesel     $
end_sc2tasks
; ----------------------------------------------------------------------------


; --  manage sc3-period tasks ------------------------------------------------
begin_sc3tasks
        btfss       SCREG, SC3OF                ; SC3 timer overflow?
        goto        end_sc3tasks                ; not time yet
        nop
        nop
        pagesel     task_50ms_action
        call        task_50ms_action            ; yes, execute tasks
        pagesel     $
end_sc3tasks
; ----------------------------------------------------------------------------


; --  manage sc4-period tasks ------------------------------------------------
begin_sc4tasks
        btfss       SCREG, SC4OF                ; SC4 timer overflow?
        goto        end_sc4tasks                ; not time yet
        nop
        nop
        pagesel     task_100ms_action
        call        task_100ms_action           ; yes, execute tasks
        pagesel     $
end_sc4tasks
; ----------------------------------------------------------------------------


; --  manage sc5-period tasks ------------------------------------------------
begin_sc5tasks
        btfss       SCREG, SC5OF                ; SC5 timer overflow?
        goto        end_sc5tasks                ; not time yet
        nop
        nop
        pagesel     task_250ms_action
        call        task_250ms_action           ; yes, execute tasks
        pagesel     $
end_sc5tasks
; ----------------------------------------------------------------------------


; --  manage sc6-period tasks ------------------------------------------------
begin_sc6tasks
        btfss       SCREG, SC6OF                ; SC6 timer overflow?
        goto        end_sc6tasks                ; not time yet
        nop
        nop
        pagesel     task_500ms_action
        call        task_500ms_action           ; yes, execute tasks
        pagesel     $
end_sc6tasks
; ----------------------------------------------------------------------------


; --  manage sc7-period tasks ------------------------------------------------
begin_sc7tasks
        btfss       SCREG, SC7OF                ; SC7 timer overflow?
        goto        end_sc7tasks                ; not time yet
        nop
        nop
        pagesel     task_1s_action
        call        task_1s_action              ; yes, execute tasks
        pagesel     $
end_sc7tasks
; ----------------------------------------------------------------------------


; --  manage sc8-period tasks ------------------------------------------------
begin_sc8tasks
        btfss       SCREG, SC8OF                ; SC8 timer overflow?
        goto        end_sc8tasks                ; not time yet
        nop
        nop
        pagesel     task_2s_action
        call        task_2s_action              ; yes, execute tasks
        pagesel     $
end_sc8tasks
; ----------------------------------------------------------------------------


; --  scheduler counters business --------------------------------------------
begin_scheduler_business
        clrf        SCREG                       ; reset scheduler register
sc1test
        decfsz      sc1Counter, F               ; countdown and test sc1 counter
        goto        end_scheduler_business      ; not time yet
        movlw       SC1CYCLES                   ; yes, reset counter
        movwf       sc1Counter
        bsf         SCREG, SC1OF                ; and set bitflag
        nop
sc2test
        decfsz      sc2Counter, F               ; countdown and test sc2 counter
        goto        end_scheduler_business      ; not time yet
        movlw       SC2CYCLES                   ; yes, reset counter
        movwf       sc2Counter
        bsf         SCREG, SC2OF                ; and set bitflag
        nop
sc3test
        decfsz      sc3Counter, F               ; countdown and test sc3 counter
        goto        end_scheduler_business      ; not time yet
        movlw       SC3CYCLES                   ; yes, reset counter
        movwf       sc3Counter
        bsf         SCREG, SC3OF                ; and set bitflag
        nop
sc4test
        decfsz      sc4Counter, F               ; countdown and test sc4 counter
        goto        sc5test                     ; not time yet
        movlw       SC4CYCLES                   ; yes, reset counter
        movwf       sc4Counter
        bsf         SCREG, SC4OF                ; and set bitflag
        nop
sc5test
        decfsz      sc5Counter, F               ; countdown and test sc5 counter
        goto        end_scheduler_business      ; not time yet
        movlw       SC5CYCLES                   ; yes, reset counter
        movwf       sc5Counter
        bsf         SCREG, SC5OF                ; and set bitflag
        nop
sc6test
        decfsz      sc6Counter, F               ; countdown and test sc6 counter
        goto        end_scheduler_business      ; not time yet
        movlw       SC6CYCLES                   ; yes, reset counter
        movwf       sc6Counter
        bsf         SCREG, SC6OF                ; and set bitflag
        nop
sc7test
        decfsz      sc7Counter, F               ; countdown and test sc7 counter
        goto        end_scheduler_business      ; not time yet
        movlw       SC7CYCLES                   ; yes, reset counter
        movwf       sc7Counter
        bsf         SCREG, SC7OF                ; and set bitflag
        nop
sc8test
        decfsz      sc8Counter, F               ; countdown and test sc8 counter
        goto        end_scheduler_business      ; not time yet
        movlw       SC8CYCLES                   ; yes, reset counter
        movwf       sc8Counter
        bsf         SCREG, SC8OF                ; and set bitflag
        nop
end_scheduler_business
; ----------------------------------------------------------------------------

endmainloop
        goto        mainloop

        return

        END                                     ; end module