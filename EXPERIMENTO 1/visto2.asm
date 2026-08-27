     .cdecls   "msp430.h"
     .global main
     .text

main:
     mov.w     #(WDTPW|WDTHOLD), &WDTCTL

     mov.w     #vetor,   R12
     mov.b     #N,   R13

     call extremos

fim:
     jmp       $
     nop

extremos:
     push      R4
     mov.b     #0,  R4

     tst       R13
     jz        fim_loop

     mov.w     @R12+, R14 ; R14 menor
     mov.w     R14, R15 ; R15 maior

     dec       R13

loop:
     tst       R13
     jz        fim_loop

     mov.w     @R12+, R4

     cmp.w     R14, R4   
     jl        min

     cmp.w     R4,  R15
     jl        max

     dec       R13
     jmp       loop
min:
     mov.w     R4, R14
     dec       R13
     jmp       loop

max:
     mov.w     R4, R15
     dec       R13
     jmp       loop
     
fim_loop:
     mov.w     R14, R12
     mov.w     R15, R13
     pop       R4
     ret

     .data
vetor:    .word     -1, 0, 1, 2, 5
N:   .set     5
