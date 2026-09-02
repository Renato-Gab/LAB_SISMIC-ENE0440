    ;Escreva a sub-rotina EXTREMOS, que recebe em R12 o endereço de um vetor de
;words (que devem ser interpretadas como números com sinal) e em R13 a quantidade
;de elementos do vetor. A sub-rotina deve retornar em R12 o menor elemento do vetor e
;em R13 o maior elemento do vetor.

     .cdecls   "msp430.h"
     .global main
     .text

main:
     mov.w     #(WDTPW|WDTHOLD), &WDTCTL

     mov.w     #vetor,   R12  ;move o vetor R12
     mov.W     #5,   R13 ;move n para R13

     call      #reduceSum8     ;chama a função que soma os vetores

fim:                     ;loop infinito
     jmp       $
     nop

reduceSum8:
     push      R4        ;joga R4 na pilha
     mov.b     #0,  R4   ;zera R4

loop:
     tst       R13       ;testa se R13 é 0
     jz        sim       ;se R13 == 0 vai para a função sim

     add.b     @R12+,    R4   ;soma a posição atual do vetor em R4 e pula pra proxima posição
     dec.b       R13       ;diminui 1 em R13
     jmp       loop      ;volta para o começo

sim:
     mov.w     R4,  R12  ;move a soma total do vetor para R12
     pop       R4   ;retira R4 da pilha
     ret            ;retorna para a main

     .data     ;memoria
vetor:    .byte     1, 2, 3, 4, 5 ;vetor
