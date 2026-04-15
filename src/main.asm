; 32-bit MS COFF
%define int_21h call _interupt_21h ; Alias to simulate DOS interrupt behavior
global  _main
extern  _interupt_21h
extern _scanf
extern _printf


section .data
    input_text db 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 0
    shift db 2

    fmt db '%s', 0

section .text
_main:
    
    call _encode

    call _print

    ; Exit program with return code 0 (AH=00h)
    mov ah, 0
    mov al, 0 ; Set return code to 0
    int_21h

_encode:
    ; ceasar cipher with shift of 2 using mmx registers

    ; load input text into mmx register 8 bytes at a time

    ; add 2 to each byte, wrapping to the beginning of the alphabet if necessary

    ; store the result back to memory

_print:

    ; push encoded text onto the stack 4 bytes at at time 

    ; push format string onto the stack

    ; call printf to print the encoded text