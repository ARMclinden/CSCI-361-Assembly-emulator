; 32-bit MS COFF
%define int_21h call _interupt_21h ; Alias to simulate DOS interrupt behavior
global  _main
extern  _interupt_21h
extern _scanf
extern _printf


section .data


section .text
_main:

    ; Exit program with return code 0 (AH=00h)
    mov ah, 0
    mov al, 0 ; Set return code to 0
    int_21h
