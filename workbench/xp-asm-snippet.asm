; ----------------------------------------------------------------------------
; copy bit REG1<7> to REG2<n>
; ----------------------------------------------------------------------------
	rlf		REG1, W		; copy REG1<7> to C
	clrf	REG2
	rlf		REG2, F		; rotate C into REG2
	
	rlf		REG2, F 	; executes n times to rotate C into REG2<n>


; ----------------------------------------------------------------------------
; flip bit N in REG 
; ----------------------------------------------------------------------------
	movlw	1<<N		; bit mask to flip only bit N
	xorwf	REG, F		; flip bits in REG


; ----------------------------------------------------------------------------
; flip bit N in W 
; ----------------------------------------------------------------------------
	movf	REG, W		; get shadow copy of REG
	xorlw	1<<NREG		; flip bit N in W
	movwf	REG


; ---------------------------------------------------------------------------
; Init Timer0
; ---------------------------------------------------------------------------
init_timer0
    errorlevel	-302

    ; Clear the Timer0 registers
    banksel		TMR0
    clrf        TMR0                        ; clear module register

    ; Disable interrupts
	banksel		INTCON
    bcf         INTCON, T0IE                ; mask timer interrupt

    ; Set the Timer0 control register
    movlw       b'10000010'                 ; setup prescaler and timer (1:8)
			;	  --0-----						internal clock source
			;     ----0---						prescaler is assigned to timer0
			;	  -----010						prescaler rate = 1:8
	banksel		OPTION_REG
    movwf       OPTION_REG

    errorlevel  +302
    return
; to parametrize timer0 settings, OPTION<RBPU> flag must be managed by init port routine


; ---------------------------------------------------------------------------
; Init Ports
; ---------------------------------------------------------------------------
init_ports

        errorlevel	-302

        ; init PORTA
        banksel     PORTA
        clrf        PORTA                       ; initialize PORTA by clearing output data latches

        movlw       h'07'
        banksel     CMCON
        movwf       CMCON                       ; turn comparators off and set PORTA mode I/O digital

        movlw       ~(1<<RA0|1<<RA1|1<<RA2|1<<RA3)
        banksel     TRISA                       ; configure RA0-3 as outputs
        movwf       TRISA

        ; init PORTB
        banksel     PORTB
        clrf        PORTB                       ; initialize PORTB by clearing output data latches

        movlw       1<<RB0|1<<RB1|1>>RB2|1<<RB3
        banksel     TRISB
        movwf       TRISB                       ; configure RB0-3 as inputs

        errorlevel  +302

        return


; ---------------------------------------------------------------------------
; 
; ---------------------------------------------------------------------------

