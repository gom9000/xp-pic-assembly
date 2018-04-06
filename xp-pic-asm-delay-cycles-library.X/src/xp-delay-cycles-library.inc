;=============================================================================
; @(#)xp-delay-cycles-library.inc
;                       ________.________
;   ____   ____  ______/   __   \   ____/
;  / ___\ /  _ \/  ___/\____    /____  \ 
; / /_/  >  <_> )___ \    /    //       \
; \___  / \____/____  >  /____//______  /
;/_____/            \/                \/ 
; Copyright (c) 2018 by Alessandro Fraschetti (gos95@gommagomma.net).
;
; This file is part of the xp-pic-asm project:
;     https://github.com/gos95-electronics/xp-pic-asm
; This code comes with ABSOLUTELY NO WARRANTY.
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
;    2500       500us    625us    1ms   2.5ms
;    5000         1ms   1.25ms    2ms     5ms
;   10000         2ms    2.5ms    4ms    10ms
;   25000         5ms   6.25ms   10ms    25ms
;   50000        10ms   12.5ms   20ms    50ms
;  100000        20ms     25ms   40ms   100ms
;  250000        50ms   62.5ms  100ms   250ms
;  500000       100ms    125ms  200ms   500ms
; 1250000       250ms  312.5ms  500ms  1.25s
; 2500000       500ms    625ms    1s    2.5s
; 5000000         1s    1.25s     2s      5s
;=============================================================================

    EXTERN      xpDelay2500
    EXTERN      xpDelay5000
    EXTERN      xpDelay10000
    EXTERN      xpDelay25000
    EXTERN      xpDelay50000
    EXTERN      xpDelay100000
    EXTERN      xpDelay250000
    EXTERN      xpDelay500000
    EXTERN      xpDelay1250000
    EXTERN      xpDelay2500000
    EXTERN      xpDelay5000000