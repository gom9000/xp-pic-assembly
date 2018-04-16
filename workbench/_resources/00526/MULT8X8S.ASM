	LIST    P = 16C54, n = 66
;
;*******************************************************************
;                   8x8 Software Multiplier
;               ( Code Efficient : Looped Code )
;*******************************************************************
;
;   The 16 bit result is stored in 2 bytes
;
; Before calling the subroutine " mpy ", the multiplier should
; be loaded in location " mulplr ", and the multiplicand in
; " mulcnd " . The 16 bit result is stored in locations
; H_byte & L_byte.
;
;       Performance :
;                       Program Memory  :  15 locations
;                       # of cycles     :  71
;                       Scratch RAM     :   0 locations
;
;
;       Program:          MULT8x8S.ASM 
;       Revision Date:   
;                         1-13-97      Compatibility with MPASMWIN 1.40
;
;  This routine is optimized for code efficiency ( looped code )
;  For time efficiency code refer to "mult8x8F.asm" ( straight line code )
;*******************************************************************
;
mulcnd  equ     09      ; 8 bit multiplicand
mulplr  equ     10      ; 8 bit multiplier
H_byte  equ     12      ; High byte of the 16 bit result
L_byte  equ     13      ; Low byte of the 16 bit result
count   equ     14      ; loop counter
;
;
	include         "p16c5x.inc"

Same    equ     1

;
; *****************************         Begin Multiplier Routine
mpy_S   clrf    H_byte
	clrf    L_byte
	movlw   8
	movwf   count
	movf    mulcnd,W
	bcf     STATUS,C    ; Clear the carry bit in the status Reg.
loop    rrf     mulplr, F
	btfsc   STATUS,C
	addwf   H_byte,Same
	rrf     H_byte,Same
	rrf     L_byte,Same
	decfsz  count, F
	goto    loop
;
	retlw   0
;
;********************************************************************
;               Test Program
;*********************************************************************
main    movlw   0FF
	movwf   mulplr          ; multiplier (in mulplr) = 0FF
	movlw   0FF             ; multiplicand(W Reg )   = 0FF
	movwf   mulcnd
;
	call    mpy_S           ; The result 0FF*0FF = FE01 is in locations
;                               ; H_byte & L_byte
;
self    goto    self
;
	org     01FF
	goto    main
;
	END

