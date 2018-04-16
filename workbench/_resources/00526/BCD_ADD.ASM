	LIST    P = 16C54, n = 66
;
;*******************  Unsigned BCD Addition   ***************
;
;       This routine performs a 2 Digit Unsigned BCD Addition
; It is assumed that the two BCD numbers to be added are in
; locations Num_1 & Num_2. The result is the sum of Num_1+Num_2
; and is stored in location Num_2 and the overflow carry is returned
; in location Num_1
;
;   Performance :
;               Program Memory  :       25
;               Clock Cycles    :       23   ( worst case )
;
;       Rev 2.0 changed on 7/30/92.
;
;       Program:          BCD_ADD.ASM 
;       Revision Date:   
;                         1-13-97      Compatibility with MPASMWIN 1.40
;
;
;*******************************************************************;
;
Num_1   equ     8       ; Overflow flow carry overwrites Num_1
result  equ     8
;
Num_2   equ     9       ; Num_2 + Num_1 overwrites Num_2
O_flow  equ     9
;
;
	include         "p16c5x.inc"
;
BCDAdd  movf    Num_1,W
	addwf   Num_2, F       ; do binary addition
	clrf    Num_1
	rlf     Num_1, F
	btfsc   STATUS,DC       ; Is DC = 0 ?
	goto    adjust          ; adjust LSD
	movlw   6
	addwf   Num_2, F        ; Test for LSD > 9 ( by adding 6
	btfsc   STATUS,C
	incf    Num_1, F
	btfss   STATUS,DC       ; & checking Digit Carry
	subwf   Num_2, F        ; LSD < 9 , so get back original value.
	goto    over1
adjust  movlw   6
	addwf   Num_2, F
over1   movlw   60              ; add 6 to MSD
	addwf   Num_2, F
	btfsc   STATUS,C
	goto    over3
	btfss   Num_1,0
	subwf   Num_2, F
	RETLW   0
over3   movlw   1
	movwf   Num_1
	RETLW   0
;
;********************************************************************
;               Test Program
;*********************************************************************
main    movlw   99
	movwf   Num_1      ; Set Num_1 = 99 ( max BCD digit )
	movlw   99
	movwf   Num_2      ; Set Num_2 = 99
;
	call    BCDAdd     ; After addition, Num_2 = 98
;                          ;  and Num_1 = 01 ( 99+99 = 198 -> max number )
;
self    goto    self
;
	org     1FF
	goto    main
;
	END




