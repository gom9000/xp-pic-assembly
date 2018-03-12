;=============================================================================
; @(#)processor.inc
;                       ________.________
;   ____   ____  ______/   __   \   ____/
;  / ___\ /  _ \/  ___/\____    /____  \ 
; / /_/  >  <_> )___ \    /    //       \
; \___  / \____/____  >  /____//______  /
;/_____/            \/                \/ 
; Copyright (c) 2017 by Alessandro Fraschetti (gos95@gommagomma.net).
;
; This file is part of the xp-pic-asm project:
;     https://github.com/gos95-electronics/xp-pic-asm
; This code comes with ABSOLUTELY NO WARRANTY.
;
; Author.....: Alessandro Fraschetti
; Company....: gos95
; Target.....: Microchip PIC 16Fxxx Microcontroller
; Compiler...: Microchip Assembler (MPASM)
; Version....: 1.1 2018/03/11 - source refactory
;              1.0 2017/05/20
; Description:
;  Select include based on processor symbol passed from MPLAB.
;=============================================================================

		IFDEF		__16F628
		INCLUDE		p16f628.inc
MPU=628
		ENDIF

		IFDEF		__16F628A
		INCLUDE		p16f628a.inc
MPU=628
		ENDIF

		IFDEF		__16F648A
		INCLUDE		p16f648a.inc
MPU=628
		ENDIF