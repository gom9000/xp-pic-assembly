;=============================================================================
; @(#)xp-delay-cycles-500000.asm
;                       ________.________
;   ____   ____  ______/   __   \   ____/
;  / ___\ /  _ \/  ___/\____    /____  \ 
; / /_/  >  <_> )___ \    /    //       \
; \___  / \____/____  >  /____//______  /
;/_____/            \/                \/ 
; Copyright (c) 2018 Alessandro Fraschetti (gos95@gommagomma.net).
;
; This file is part of the pic-assembly-xp project:
;     https://github.com/pic-assembly-xp
;
; Author.....: Alessandro Fraschetti
; Company....: gos95
; Target.....: Microchip Mid-Range PICmicro
; Compiler...: Microchip Assembler (MPASM)
; Version....: 1.0 2018/03/09
;
; Module.....: xpDelay500000
; Description: 500000 cycles delay routine
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


    TITLE       'xpDelay500000 - 500000 cycles delay'
    SUBTITLE    'Part of the xp-delay-cycles-library'

    GLOBAL      xpDelay500000


;=============================================================================
;  VARIABLE DEFINITIONS
;=============================================================================
; Unitialized Data Section
GPR_MODULE_VAR      UDATA
localvar1           RES     1
localvar2           RES     1
localvar3           RES     1


;=============================================================================
;  MODULE PROGRAM
;=============================================================================
MODULE              CODE                        ; begin module
xpDelay500000
        movlw       0x03                        ; 499994 cycles
        movwf       localvar1
        movlw       0x18
        movwf       localvar2
        movlw       0x02
        movwf       localvar3
delay500000_loop
        decfsz      localvar1, F
        goto        $+2
        decfsz      localvar2, F
        goto        $+2
        decfsz      localvar3, F
        goto        delay500000_loop
        goto        $+1                         ; 2 cycles

        return                                  ; 4 cycles (including call)

        END                                     ; end module