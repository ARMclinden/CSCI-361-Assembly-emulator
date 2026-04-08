; 32-bit MS COFF
%define int_21h call _interupt_21h ; Alias to simulate DOS interrupt behavior
global  _main
extern  _interupt_21h


section .data
    x dq 1.0 ;initial guess
    S dq 0.0 ;Input

    half dq 0.5
    fmt db "%lf", 0

section .text
_main:

    

    ; Exit program with return code 0 (AH=00h)
    mov ah, 0
    mov al, 0 ; Set return code to 0
    int_21h