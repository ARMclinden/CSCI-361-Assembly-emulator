; 32-bit MS COFF
%define int_21h call _interupt_21h ; Alias to simulate DOS interrupt behavior
global  _main
extern  _interupt_21h
extern _scanf
extern _printf
extern _exit

; Andrew Ryan McLinden
; CSCI 361 Spring 2026
; Assignment class 31
; I acknowledge that I have worked on this assignment independently,
; except where explicitly noted and referenced. Any collaboration or
; use of external resources has been properly cited.
; I am fully aware of the consequences of academic dishonesty and
; agree to abide by the university's academic integrity policy.

section .data
vector_a dd 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0
vector_b dd 1.0, 1.0, 1.0, 1.0, 2.0, 2.0, 2.0, 2.0, 3.0, 3.0, 3.0, 3.0
result dq 0.0
padding db 0, 0, 0, 0, 0, 0, 0, 0
fmt db "%lf",10,13,0

;expected output 1*1+2*1+3*1+4*1+5*2+6*2+7*2+8*2+9*3+10*3+11*3+12*3= 10+52+126 = 188.000000

section .text
_main:

    call cross_product

    movsd [result], xmm0
    
    push dword [result + 4]
    push dword [result]
    push fmt

    call _printf
    
    ; Exit program with return code 0 (AH=00h)
    push 0
    call _exit

cross_product:
    
    xor ecx, ecx

    .loop1:
        movups xmm0, [vector_a + ecx]
        movups xmm1, [vector_b + ecx]

        mulps xmm1, xmm0

        movhlps xmm2, xmm1
        movlhps xmm3, xmm1


        cvtps2pd xmm2, xmm2
        shufps xmm3, xmm3, 01001110b
        cvtps2pd xmm3, xmm3

        addpd xmm3, xmm2

        movhlps xmm4, xmm3
        movlhps xmm5, xmm3

        shufpd xmm4, xmm4, 01b

        addpd xmm4, xmm5

        addpd xmm6, xmm4

        xorps xmm4, xmm4
        xorps xmm5, xmm5

        add ecx, 16
        cmp ecx, 48
        jbe .loop1

    movups xmm0, xmm6
    shufpd xmm0, xmm0, 11b
    
ret