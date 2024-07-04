# PIC Assembly eXPerience
Various MPLAB-X home projects to learn Mid-Range PICmicro assembly programming.


## Contents

### Code Templates
Assembly code templates for absolute and relocatable code sources:

* [xp-pic-asm-template-absolute](xp-pic-asm-template/xp-pic-asm-template-absolute.X/)
-- template for absolute code sources
* [xp-pic-asm-template-relocatable](xp-pic-asm-template/xp-pic-asm-template-relocatable.X/)
-- template for relocatable code sources

### Delay
Delay routines:

* [xp-pic-asm-delay](xp-pic-asm-delay/xp-pic-asm-delay.X/)
-- simple implementation of 20MHz delay routines base on code from: http://www.piclist.com/techref/piclist/codegen/delay.htm
* [xp-pic-asm-delay-cycles-library](xp-pic-asm-delay/xp-pic-asm-delay-cycles-library.X/)
-- a Library version of the delay routines
* [xp-pic-asm-delay-library-test](xp-pic-asm-delay/xp-pic-asm-delay-library-test.X/)
-- test code for the delay library

### I/O
Input/Output management routines:

* [xp-pic-asm-io-digital-debounce](xp-pic-asm-io/xp-pic-asm-io-digital-debounce.X/)
-- implementation of software debounce tecniques for input switches
* [xp-pic-asm-io-digital-array](xp-pic-asm-io/xp-pic-asm-io-digital-array.X/)
-- software management for arrays of input switch and led

### Scheduler
A simple scheduler manager for executing tasks at regular intervals:

* [xp-pic-asm-scheduler](xp-pic-asm-scheduler/xp-pic-asm-scheduler.X/)
-- the scheduler implementation using Timer0
* [xp-pic-asm-scheduler-library](xp-pic-asm-scheduler/xp-pic-asm-scheduler-library.X/)
-- a library version of the scheduler
* [xp-pic-asm-scheduler-library-test](xp-pic-asm-scheduler/xp-pic-asm-scheduler-library-test.X/)
-- test code for scheduler library

### 32-bit
32-bit arithmetic routines:

* [xp-pic-asm-int32](xp-pic-asm-int32/xp-pic-asm-int32.X/)
-- implementation of 32-bit (quadruple) integer arithmetic