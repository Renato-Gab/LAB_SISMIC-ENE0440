     .cdecls   "msp430.h"
     .global main
     .text

main:
     mov.w     #(WDTPW|WDTHOLD), &WDTCTL

     mov.w     #vetor,   R12
     mov.b     #N,   R13

     call reduceSum8

fim:
     jmp       $
     nop

reduceSum8:
     push      R4
     mov.b     #0,  R4

loop:
     tst       R13
     jz        sim

     add.b     @R12+,    R4
     dec       R13
     jmp       loop

sim:
     mov.b     R4,  R12
     pop       R4
     ret

     .data
vetor:    .byte     1, 2, 3, 4, 5
N:   .set     5
