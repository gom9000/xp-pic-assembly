	LIST    P = 16C54, n = 66
;
;*******************************************************************
;       Binary Floating Point Addition, Subtraction, Multiplication
;                       and Divide routines.
;
;
;       Program:          FLOAT.ASM 
;       Revision Date:   
;                         1-13-97      Compatibility with MPASMWIN 1.40
;
;*******************************************************************;
;
;   Addition :  ACCb(16 bits) + ACCa(16 bits) -> ACCb(16 bits)
;      (a) Load the 1st operand in location ACCaLO & ACCaHI ( 16 bits ) with
;          the 8 bit exponent in EXPa.
;      (b) Load the 2nd operand in location ACCbLO & ACCbHI ( 16 bits ) with
;          the 8 bit exponent in EXPb.
;      (c) CALL F_add
;      (d) The result is in location ACCbLO & ACCbHI ( 16 bits ) with
;          the 8 bit exponent in EXPb
;
;       Program Memory :        55 locations
;
;*******************************************************************;
;
;   Subtraction : ACCb(16 bits) - ACCa(16 bits) -> ACCb(16 bits)
;      (a) Load the 1st operand in location ACCaLO & ACCaHI ( 16 bits ) with
;          the 8 bit exponent in EXPa .
;      (b) Load the 2nd operand in location ACCbLO & ACCbHI ( 16 bits ) with
;          the 8 bit exponent in EXPb .
;      (c) CALL F_sub
;      (d) The result is in location ACCbLO & ACCbHI ( 16 bits ) with
;          the 8 bit exponent in EXPb.
;
;       Program Memory :        61 locations
;
;*******************************************************************;
;
;   Multiplication :
;   ACCb(16 bits)EXP(b) * ACCa(16 bits)EXPa -> ACCb(16 bits)EXPb
;   where, EXP(x) represents an 8 bit exponent.
;      (a) Load the 1st operand in location ACCaLO & ACCaHI ( 16 bits ) with
;                               an 8 bit exponent in location EXPa
;      (b) Load the 2nd operand in location ACCbLO & ACCbHI ( 16 bits ) with
;                               an 8 bit exponent in location EXPb
;      (c) CALL F_mpy
;      (d) The 16 bit result overwrites ACCb(ACCbLO & ACCbHI). The exponent
;               is stored in EXPb and the results are normalized.
;
; NOTE : If one needs to get a 32 bit product( & an 8 bit exponent ),
;        re assemble the program after changing the line " Mode16 equ TRUE"
;        to " Mode16  equ  FALSE ".
;        If this option is chosen, then the 32 bit result is returned in
;        ( ACCbHI, ACCbLO, ACCcHI, ACCcLO ) and the 8 bit exponent in EXPb.
;        This method ( with " Mode16 equ FALSE " ) is NOT Recommended.
;
;       Program Memory :        102 locations
;
;*******************************************************************;
;
;   Division :
;       ACCb(16 bits)EXP(b) / ACCa(16 bits)EXP(a) -> ACCb(16 bits)EXP(b)
;                                       with Remainder in ACCc (16 bits)
;      (a) Load the Denominator in location ACCaHI & ACCaLO ( 16 bits )
;                                               with exponent in EXPa
;      (b) Load the Numerator in location ACCbHI & ACCbLO ( 16 bits )
;                                               with exponent in EXPa
;      (c) CALL F_div
;      (d) The 16 bit result is in location ACCbHI & ACCbLO
;                                       with exponent in EXPb
;      (e) The 16 bit Remainder is in locations ACCcHI & ACCcLO
;
;       Program Memory :        86 locations
;
;*******************************************************************;
;
ACCaLO  equ     10
ACCaHI  equ     11
EXPa    equ     12
ACCbLO  equ     13
ACCbHI  equ     14
EXPb    equ     15
ACCcLO  equ     16
ACCcHI  equ     17
ACCdLO  equ     18
ACCdHI  equ     19
temp    equ     1A
sign    equ     1B
;
	include "p16c5x.inc"

PIC54   equ     1FFH    ; Define Reset Vector
TRUE    equ     1
FALSE   equ     0
MSB     equ     7

;
Mode16  equ     TRUE            ; Change this to FALSE if a 32 bit product
;                               ; is desired for F_mpy routine.
;
	org     0
;*******************************************************************
;       Floating Point Subtraction  ( ACCb - ACCa -> ACCb )
;
F_sub   call    neg_A           ; At first negate ACCa; Then add
;
F_add   movf    EXPa,W          ; scale mantissas
	subwf   EXPb,W          ; find the greater exponent
	btfsc   STATUS,Z
	goto    padd            ; exponents are equal
	btfsc   STATUS,C    ;
	call    F_swap          ; if A > B then swap ( A<->B )
	movf    EXPa,W
	subwf   EXPb, F
scloop  call    shftSR
	incfsz  EXPb, F
	goto    scloop
	movf    EXPa,W
	movwf   EXPb
padd    movf    ACCaHI,W
	iorwf   ACCbHI,W
	movwf   sign
	call    D_add           ; compute double precision integer add
	btfss   sign,MSB
	btfss   ACCbHI,MSB
	retlw   0
	bcf     STATUS,C
	incf    EXPb, F
	goto    shftR
;
;*******************************************************************
;         Double Precision Subtraction ( ACCb - ACCa -> ACCb )
;
D_sub   call    neg_A           ; At first negate ACCa; Then add
;
D_add   movf    ACCaLO,W        ; Addition ( ACCb + ACCa -> ACCb )
	addwf   ACCbLO, F       ;add lsb
	btfsc   STATUS,C    ;add in carry
	incf    ACCbHI, F
	movf    ACCaHI,W
	addwf   ACCbHI, F       ;add msb
	retlw   0
;*******************************************************************
;
;
shftSR  bcf     STATUS,C
	btfsc   ACCbHI,MSB
	bsf     STATUS,C            ; set carry if < 0
shftR   rrf     ACCbHI, F
	rrf     ACCbLO, F
	retlw   0
;
shftSL  bcf     STATUS,C
;
	if   Mode16
	rlf     ACCcLO, F
	rlf     ACCcHI, F
	endif
;
	rlf     ACCbLO, F
	rlf     ACCbHI, F
	bcf     ACCbHI,MSB
	btfsc   STATUS,C
	bsf     ACCbHI,MSB
	retlw   0
;
;*******************************************************************
;   Binary Floating Point Multiplication :
;   ACCb(16 bits)EXP(b) * ACCa(16 bits)EXPa -> ACCb(16 bits)EXPb
;
F_mpy
	call    S_SIGN
	call    setup
mloop   bcf     STATUS,C    ; clear carry bit       ??????????
	rrf     ACCdHI, F       ;rotate d right
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
	movf    EXPa,W
	addwf   EXPb, F
;
	IF   Mode16
	movf    ACCbHI, F
	btfss   STATUS,Z
	goto    finup           ; if ACCbHI != 0
	movf    ACCbLO, F
	btfss   STATUS,Z
	goto    Shft08          ; if ACCbLO != 0 && ACCbHI == 0
;
	movf    ACCcHI,W
	movwf   ACCbHI          ; if ACCb == 0, then move ACCc to ACCb
	movf    ACCcLO,W
	movwf   ACCbLO
	movlw   .16
	addwf   EXPb, F
	goto    finup
;
Shft08  movf    ACCbLO,W
	movwf   ACCbHI
	movf    ACCcHI,W
	movwf   ACCbLO
	movlw   .8
	addwf   EXPb, F
;
	ENDIF                   ; matching endif for IF Mode16
;
finup   btfss   sign,MSB
	goto    F_norm
;
	decf    ACCcLO, F       ; negate ACCc
	comf    ACCcLO, F
	btfsc   STATUS,Z
	decf    ACCcHI, F
	comf    ACCcHI, F
	btfsc   STATUS,Z
;
neg_B   decf    ACCbLO, F       ; negate ACCb
	comf    ACCbLO, F
	btfsc   STATUS,Z
	decf    ACCbHI, F
	comf    ACCbHI, F
;
	goto    F_norm
;
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
	clrf    ACCbLO          ; clear ACCb ( ACCbLO & ACCbHI )
	retlw   0
;

;*******************************************************************
;   Floating Point Division :
;   ACCb(16 bits)EXP(b) / ACCa(16 bits)EXPa -> ACCb(16 bits)EXPb , with
;                               remainder in ACCc ( 16 bits ).
;
F_div   call    S_SIGN
	call    setup
	clrf    ACCcHI
	clrf    ACCcLO
dloop   bcf     STATUS,C     ;????????
	rlf     ACCdLO, F
	rlf     ACCdHI, F
	rlf     ACCcLO, F
	rlf     ACCcHI, F
	movf    ACCaHI,W        ; check if ACCa > ACCb
	subwf   ACCcHI,W
	btfss   STATUS,Z
	goto    nochk
	movf    ACCaLO,W
	subwf   ACCcLO,W        ;if msb equal then check lsb
nochk   btfss   STATUS,C    ;carry set if c>a
	goto    nogo
	movf    ACCaLO,W        ;c-a into c
	subwf   ACCcLO, F
	btfss   STATUS,C
	decf    ACCcHI, F
	movf    ACCaHI,W
	subwf   ACCcHI, F
	bsf     STATUS,C    ;shift a 1 into b (result)
nogo    rlf     ACCbLO, F
	rlf     ACCbHI, F
	decfsz  temp, F         ;loop untill all bits checked
	goto    dloop
	movf    EXPa,W
	subwf   EXPb, F
	btfss   sign,MSB
	goto    F_norm
	decf    ACCbLO, F       ; negate ACCb
	comf    ACCbLO, F
	btfsc   STATUS,Z
	decf    ACCbHI, F
	comf    ACCbHI, F
	goto    F_norm
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
;
S_SIGN  movf    ACCaHI,W
	xorwf   ACCbHI,W
	movwf   sign
	btfss   ACCbHI,MSB        ; if MSB set go & negate ACCb
	goto    chek_A
;
	comf    ACCbLO, F        ; negate ACCb
	incf    ACCbLO, F
	btfsc   STATUS,Z
	decf    ACCbHI, F
	comf    ACCbHI, F
;
chek_A  btfss   ACCaHI,MSB        ; if MSB set go & negate ACCa
	retlw   0
	goto    neg_A
;
;*******************************************************************
;      Normalize Routine
; Normalizes ACCb for use in floating point calculations.
; Call this routine as often as possible to minimize the loss
; of precission. This routine normalizes ACCb so that the
; mantissa is maximized and the exponent minimized.
;
;
;
F_norm  movf    ACCbHI, F
	btfss   STATUS,Z
	goto    C_norm
	movf    ACCbLO, F
	btfsc   STATUS,Z
	retlw   0
C_norm  btfsc   ACCbHI,6
	retlw   0
	call    shftSL
	decf    EXPb, F
	goto    C_norm
;
;*******************************************************************
;  Swap ACCa & ACCb   [ (ACCa,EXPa) <--> (ACCb,EXPb) ]
;
F_swap
	movf    ACCaHI,W
	movwf   temp
	movf    ACCbHI,W        ;ACCaHI <--> ACCbHI
	movwf   ACCaHI
	movf    temp,W
	movwf   ACCbHI
;
	movf    ACCaLO,W
	movwf   temp
	movf    ACCbLO,W        ;ACCaLO <--> ACCbLO
	movwf   ACCaLO
	movf    temp,W
	movwf   ACCbLO
;
	movf    EXPa,W
	movwf   temp
	movf    EXPb,W          ;EXPa <--> EXPb
	movwf   EXPa
	movf    temp,W
	movwf   EXPb
;
	retlw   0
;
;*******************************************************************
;                       Test Program
;*******************************************************************
;    Load constant values to (ACCa, EXPa) & (ACCb, EXPb) for testing
;
loadAB  movlw   1
	movwf   ACCaHI
	movlw   0FF             ; loads ACCa = 01FF EXP(4)
	movwf   ACCaLO
	movlw   04
	movwf   EXPa
;
	movlw   07F
	movwf   ACCbHI
	movlw   0FF             ; loads ACCb = 7FFF EXP(6)
	movwf   ACCbLO
	movlw   06
	movwf   EXPb
	retlw   0
;
main    nop
;
	call    loadAB          ; result of adding ACCb(EXPb)+ACCa(EXPa)->ACCb(EXPb)
	call    F_add           ; Here Accb = 403F, EXPb = 07
;
	call    loadAB          ; result of subtracting ACCb(EXPb)-ACCa(EXPa)->ACCb(EXPb)
	call    F_sub           ; Here Accb = 7F7F, EXPb = 06
;
	call    loadAB          ; result of multiplying ACCb(EXPb) * ACCa(EXPa)->ACCb(EXPb)
	call    F_mpy           ; Here ACCb = FF7E, EXPb = 12
;
	call    loadAB          ; result of dividing ACCb(EXPb) / ACCa(EXPa)->ACCb(EXPb) with
	call    F_div           ; remainder in ACCc. Here ACCb =4000, EXPb = FA (same as -6)
;                               ; & the remainder ACCc = 003F
;
self    goto    self
;
	org     PIC54
	goto    main
	END
;****************************************************************
