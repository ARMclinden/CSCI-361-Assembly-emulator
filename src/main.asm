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


section .text
_main:
    
    ; Exit program with return code 0 (AH=00h)
    push 0
    call _exit
