;=============================================================================
; @(#)xp-delay-cycles-library.inc
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
; Description:
;  Include file for the xp-delay-cycles library:
;
;  cycles        20MHz   16MHz   10MHz   4MHz
;    1000       200us    250us  400us     1ms
;    2500       500us    625us    1ms   2.5ms
;    4000       800us      1ms  1.6ms     4ms
;    5000         1ms   1.25ms    2ms     5ms
;   10000         2ms    2.5ms    4ms    10ms
;   25000         5ms   6.25ms   10ms    25ms
;   40000         8ms     10ms   16ms    40ms
;   50000        10ms   12.5ms   20ms    50ms
;  100000        20ms     25ms   40ms   100ms
;  250000        50ms   62.5ms  100ms   250ms
;  400000        80ms    100ms  160ms   400ms
;  500000       100ms    125ms  200ms   500ms
; 1250000       250ms  312.5ms  500ms  1.25s
; 2500000       500ms    625ms    1s    2.5s
; 5000000         1s    1.25s     2s      5s
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


    EXTERN      xpDelay1000
    EXTERN      xpDelay2500
    EXTERN      xpDelay4000
    EXTERN      xpDelay5000
    EXTERN      xpDelay10000
    EXTERN      xpDelay25000
    EXTERN      xpDelay40000
    EXTERN      xpDelay50000
    EXTERN      xpDelay100000
    EXTERN      xpDelay250000
    EXTERN      xpDelay400000
    EXTERN      xpDelay500000
    EXTERN      xpDelay1250000
    EXTERN      xpDelay2500000
    EXTERN      xpDelay5000000