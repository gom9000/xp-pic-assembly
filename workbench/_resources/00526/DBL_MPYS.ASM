	LIST    P = 16C54,  n = 66
;
;*******************************************************************
;                    Double Precision Multiplication
;
;               ( Optimized for Code Size : Looped Code )
;
;*******************************************************************;
;   Multiplication : ACCb(16 bits) * ACCa(16 bits) -> ACCb,ACCc ( 32 bits )
;      (a) Load the 1st operand in location ACCaLO & ACCaHI ( 16 bits )
;      (b) Load the 2nd operand in location ACCbLO & ACCbHI ( 16 bits )
;      (c) CALL D_mpy
;      (d) The 32 bit result is in location ( ACCbHI,ACCbLO,ACCcHI,ACCcLO )
;
;   Performance :
;               Program Memory  :       033
;               Clock Cycles    :       333
;
;       Note : The above timing is the worst case timing, when the
;               register ACCb = FFFF. The speed may be improved if
;               the register ACCb contains a number ( out of the two
;               numbers ) with less number of 1s.
;               The performance specs are for Unsigned arithmetic ( i.e,
;               with "SIGNED equ  FALSE ").
;
;               The performance specs are for Unsigned arithmetic ( i.e,
;               with "SIGNED equ  FALSE ").
;
;
;       Program:          DBL_MPYS.ASM 
;       Revision Date:   
;                         1-13-97      Compatibility with MPASMWIN 1.40
;
;*******************************************************************;
;
ACCaLO  equ     0x10
ACCaHI  equ     0x11
ACCbLO  equ     0x12
ACCbHI  equ     0x13
ACCcLO  equ     0x14
ACCcHI  equ     0x15
ACCdLO  equ     0x16
ACCdHI  equ     0x17
temp    equ     0x18
sign    equ     0x19
Flags	equ	0x1F
;
	include "p16c5x.inc"

PIC54   equ     1FFH    ; Define Reset Vector
TRUE    equ     1
FALSE   equ     0
MSB     equ     7

	org     0
;*******************************************************************
SIGNED  equ     TRUE            ; Set This To 'TRUE' if the routines
;                               ; for Multiplication & Division needs
;                               ; to be assembled as Signed Integer
;                               ; Routines. If 'FALSE' the above two
;                               ; routines ( D_mpy & D_div ) use
;                               ; unsigned arithmetic.
;*******************************************************************
;         Double Precision Addition ( ACCb + ACCa -> ACCb )
;
D_add   bcf	Flags,C	;Clear temp Carry bit
	movf    ACCaLO,W        ; Addition ( ACCb + ACCa -> ACCb )
	addwf   ACCbLO, F       ;add lsb
	btfsc   STATUS,C    ;add in carry
 	incf    ACCbHI, F
	btfsc	STATUS,C
	bsf	Flags,C	
	movf    ACCaHI,W
	addwf   ACCbHI, F         ;add msb
	btfsc	Flags,C
	bsf	STATUS,C
	retlw   0
;*******************************************************************
;               Double Precision Multiply ( 16x16 -> 32 )
;         ( ACCb*ACCa -> ACCb,ACCc ) : 32 bit output with high word
;  in ACCb ( ACCbHI,ACCbLO ) and low word in ACCc ( ACCcHI,ACCcLO ).
;
D_mpyS                           ;results in ACCb(16 msb's) and ACCc(16 lsb's)
;
     IF   SIGNED
     CALL    S_SIGN
     ENDIF
;
	call    setup
mloop   rrf     ACCdHI, F       ;rotate d right
	rrf     ACCdLO, F
	btfsc   STATUS,C    ;need to add?
	call    D_add
	rrf     ACCbHI, F
	rrf     ACCbLO, F
	rrf     ACCcHI, F
	rrf     ACCcLO, F
	decfsz  temp, F         ;loop until all bits checked
	goto    mloop
;
    IF    SIGNED
	btfss   sign,MSB
	retlw   0
	comf    ACCcLO, F       ; negate ACCa ( -ACCa -> ACCa )
	incf    ACCcLO, F
	btfsc   STATUS,Z
	decf    ACCcHI, F
	comf    ACCcHI, F
	btfsc   STATUS,Z
neg_B   comf    ACCbLO, F       ; negate ACCb
	incf    ACCbLO, F
	btfsc   STATUS,Z
	decf    ACCbHI, F
	comf    ACCbHI, F
	retlw   0
    ELSE
	retlw   0
    ENDIF
;
;*******************************************************************
;
setup   movlw   .16             ; for 16 shifts
	movwf   temp
	movf    ACCbHI,W          ;move ACCb to ACCd
	movwf   ACCdHI
	movf    ACCbLO,W
	movwf   ACCdLO
	clrf    ACCbHI
	clrf    ACCbLO
	retlw   0
;
;*******************************************************************
;
neg_A   comf    ACCaLO, F       ; negate ACCa ( -ACCa -> ACCa )
	incf    ACCaLO, F
	btfsc   STATUS,Z
	decf    ACCaHI, F
	comf    ACCaHI, F
	retlw   0
;
;*******************************************************************
;  Assemble this section only if Signed Arithmetic Needed
;
     IF    SIGNED
;
S_SIGN  movf    ACCaHI,W
	xorwf   ACCbHI,W
	movwf   sign
	btfss   ACCbHI,MSB        ; if MSB set go & negate ACCb
	goto    chek_A
;
	comf    ACCbLO, F       ; negate ACCb
	incf    ACCbLO, F
	btfsc   STATUS,Z
	decf    ACCbHI, F
	comf    ACCbHI, F
;
chek_A  btfss   ACCaHI,MSB        ; if MSB set go & negate ACCa
	retlw   0
	goto    neg_A
;
     ENDIF
;
;*******************************************************************
;                       Test Program
;*******************************************************************
;    Load constant values to ACCa & ACCb for testing
;
main    movlw   1
	movwf   ACCaHI
	movlw   0FF             ; loads ACCa = 01FF
	movwf   ACCaLO
;
	movlw   0x7F
	movwf   ACCbHI
	movlw   0xFF            ; loads ACCb = 7FFF
	movwf   ACCbLO
;
	call    D_mpyS          ; Here (ACCb,ACCc) = 00FF 7E01
;
self    goto    self
;
	org     PIC54
	goto    main
	END
;****************************************************************
