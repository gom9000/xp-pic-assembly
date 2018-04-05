Dly32 MACRO DLY

;Take the delay value argument from the macro, precalculate
;the required 4 RAM values and load the The RAM values Dly3
;though Dly0.
      BANKSEL Dly3
      movlw   (DLY*.250) & H'FF'
      movwf   Dly0
      movlw   (DLY*.250) >>D'08' & H'FF'
      movwf   Dly1
      movlw   (DLY*.250) >>D'16' & H'FF'
      movwf   Dly2
      movlw   (DLY*.250) >>D'24' & H'FF'
      movwf   Dly3
      pagesel DoDly32
      call    DoDly32
      pagesel $
      ENDM        ;End of Macro definition

DoDly32
        movlw   H'FF'      ;Start with -1 in W

        addwf   Dly0,F     ;LSB decrement
        btfsc   STATUS,C   ;was the carry flag set?
        clrw               ;If so, 0 is put in W
        
        addwf   Dly1,F     ;Else, we continue.
        btfsc   STATUS,C
        clrw               ;0 in W
        
        addwf   Dly2,F
        btfsc   STATUS,C
        clrw               ;0 in W
        
        addwf   Dly3,F
        btfsc   STATUS,C 
        clrw               ;0 in W
        
        iorwf   Dly0,W     ;Inclusive-OR all variables
        iorwf   Dly1,W     ;together to see if we have reached
        iorwf   Dly2,W     ;0 on all of them.
        iorwf   Dly3,W
        btfss   STATUS,Z   ;Test if result of Inclusive-OR's is 0
        goto    DoDly32    ;It was NOT zero, so continue counting

;              goto  $+1  ;delay 2 cycles
;      goto  $+1  ;delay total of 4 cycles
;      goto  $+1
;      goto  $+1
;      goto  $+1
;      goto  $+1
;      goto  $+1
;      goto  $+1
        return