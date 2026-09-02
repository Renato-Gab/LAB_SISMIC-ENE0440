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
     mov.w     #5,   R13 ;move n para R13

     call		#extremos

fim:                     ;loop infinito
     jmp       $
     nop

extremos:
     push      R4   ;variavel temporaria
     push      R5   ;variavel maior
     push      R6   ;variavel menor
     clr       R5
     clr       R6

     tst     R13
     jz      fim_extremos

     mov.w     @R12,     R5
     mov.w     @R12,     R6

loop_extremos:
     mov.w     @R12+,   R4
     cmp.w     R6,      R4     ; R4 >= R6 ?
     jge       testa_maior     ;se R4 é maior
 
     mov.w     R4,      R6 ;Se R4 e menor que R6

testa_maior: ;ve se é maior ou igual
     cmp.w     R5, R4     ; Compara R4 com R5
     jl        proximo    ; Se R4 < R5, não é maior. Vai para o próximo elemento.
     mov.w     R4, R5     ; Se R4 >= R5, atualiza o maior elemento em R5

proximo:
     dec.w       R13
     jnz       loop_extremos

fim_extremos:
     mov.w     R6,  R12
     mov.w     R5,  R13

     pop       R6
     pop       R5
     pop       R4

     ret     
     
     .data     ;memoria
vetor:    .word     1, -1, 5, 3, -2  ;vetor
