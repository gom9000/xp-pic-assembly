	LIST    P = 16C54, n = 66
;
;*******************************************************************
;
;            Square Root By Newton Raphson Method
;
;    This routine computes the square root of a 16 bit number(with
;  low byte in NumLo & high byte in NumHi ). After loading NumLo &
;  NumHi with the desired number whose square root is to be computed,
;  branch to location Sqrt ( by "GOTO  Sqrt" ). " CALL  Sqrt" cannot
;  be issued because the Sqrt function makes calls to Math routines
;  and the stack is completely used up.
;       The result = sqrt(NumHi,NumLo) is returned in location SqrtLo.
;  The total number of iterations is set to ten. If more iterations
;  are desired, change "LupCnt equ .10" to the desired value. Also,
;  the initial guess value of the square root is given set as
;  input/2 ( in subroutine "init" ). The user may modify this scheme
;  if a better initial approximation value is known. A good initial
;  guess will help the algorithm converge at a faster rate and thus
;  less number of iterations required.
;       Two utility math routines are used by this program : D_divS
;  and D_add. These two routines are listed as seperate routines
;  under double precision Division and double precision addtion
;  respectively.
;
;  Note : If square root of an 8 bit number is desired, it is probably
;         better to have a table look scheme rather than using numerical
;         methods.
;
;
;
;   Performance :
;               Program Memory  :       27  (excluding Math Routines
;                                            D_divS & D_add )
;               Clock Cycles    :       3600 ( approximately )
;
;
;       Program:          SQRT.ASM 
;       Revision Date:   
;                         1-13-97      Compatibility with MPASMWIN 1.40
;
;       To assemble this program, two routines, namely "D_add" &
;       "D_divS" must be included into this program. These two routines
;       are listed as separate programs in files "DBL_ADD.ASM" &
;       "DBL_DIVS.ASM" respectively.
;
;*******************************************************************
	include "p16c5x.inc"

PIC54   equ     1FFH    ; Define Reset Vector
TRUE    equ     1
FALSE   equ     0

	org     0
;
LupCnt  equ     .10             ; Number of iterations
;
ACCaLO  equ     10
ACCaHI  equ     11
ACCbLO  equ     13
ACCbHI  equ     14
ACCcLO  equ     14
ACCcHI  equ     15
ACCdLO  equ     16
ACCdHI  equ     17
temp    equ     18
sign    equ     19
;
SqrtLo  equ     ACCaLO
SqrtHi  equ     ACCaHI
;
NumLo   equ     1D
NumHi   equ     1E
count   equ     1F
;
;
init
	movlw   LupCnt
	movwf   count
	movf    NumHi,W
	movwf   SqrtHi
	movf    NumLo,W         ; set initial guess root = NUM/2
	movwf   SqrtLo
	bcf     STATUS,C
	rrf     SqrtHi, F
	rrf     SqrtLo, F
	retlw   0
;
div2    bcf     STATUS,C
	rrf     ACCbHI,W
	movwf   SqrtHi
	rrf     ACCbLO,W
	movwf   SqrtLo
	retlw   0
;
;*******************************************************************
;       Double Precision  Addition ( ACCb + ACCa -> ACCb )
;
D_add   movf    ACCaLO,W
	addwf   ACCbLO, F       ;add lsb
	btfsc   STATUS,C    ;add in carry
	incf    ACCbHI, F
	movf    ACCaHI,W
	addwf   ACCbHI, F       ;add msb
	retlw   0
;
;*******************************************************************
SIGNED  equ     FALSE           ; Set This To 'TRUE' if the routines
;                               ; for Multiplication & Division needs
;                               ; to be assembled as Signed Integer
;                               ; Routines. If 'FALSE' the above two
;                               ; routines ( D_mpy & D_div ) use
;                               ; unsigned arithmetic.
;*******************************************************************
;       Double Precision Divide ( 16/16 -> 16 )
;
;         ( ACCb/ACCa -> ACCb with remainder in ACCc ) : 16 bit output
; with Quotiont in ACCb (ACCbHI,ACCbLO) and Remainder in ACCc (ACCcHI,ACCcLO).
;
;   NOTE  :  Before calling this routine, the user should make sure that
;            the Numerator(ACCb) is greater than Denominator(ACCa). If
;            the case is not true, the user should scale either Numerator
;            or Denominator or both such that Numerator is greater than
;            the Denominator.
;
;
D_divS
;
     IF   SIGNED
     CALL    S_SIGN
     ENDIF
;
	call    setup
	clrf    ACCcHI
	clrf    ACCcLO
dloop   bcf     STATUS,C
	rlf     ACCdLO, F
	rlf     ACCdHI, F
	rlf     ACCcLO, F
	rlf     ACCcHI, F
	movf    ACCaHI,W
	subwf   ACCcHI,W          ;check if a>c
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
;
    IF    SIGNED
	btfss   sign,MSB        ; check sign if negative
	retlw   0
	goto    neg_B          ; negate ACCa ( -ACCa -> ACCa )
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
	comf    ACCbLO          ; negate ACCb
	incf    ACCbLO
	btfsc   STATUS,Z
	decf    ACCbHI
	comf    ACCbHI
;
chek_A  btfss   ACCaHI,MSB        ; if MSB set go & negate ACCa
	retlw   0
	goto    neg_A
;
     ENDIF
;
;
Sqrt    call    init
sloop   movf    NumLo,W
	movwf   ACCbLO
	movf    NumHi,W
	movwf   ACCbHI
;
	call    D_divS          ; double precision division
	call    D_add           ; double precision addition
;                               ; the above 2 routines are listed
;                               ; as seperate routines
	call    div2
	decfsz  count, F
	goto    sloop
	goto    over            ; all iterations done
;                               ; branch back to desired location
;
;*************************************************************
;               Test Program
;*************************************************************
;
main    movlw   0F3
	movwf   NumHi
	movlw   0F6       ; Set input test number = 62454
	movwf   NumLo     ;  = F3F6h
;
	goto    Sqrt      ; cannot use CALL : Math routines
;                         ; use up all the stack.
over    nop               ; all iterations done
;
self    goto    self      ; result = 00F9h = 249
;                         ; exact sqrt(62454) = 249.9
;
	org     PIC54
	goto    main
;
	END
