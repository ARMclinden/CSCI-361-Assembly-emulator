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
    input_text db 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 0
    padding db 0, 0, 0, 0, 0, 0, 0, 0
    
    shift db 2
    
    spaces db 32, 32, 32, 32, 32, 32, 32, 32
    _low db 96, 96, 96, 96, 96, 96, 96, 96
    _up db 122, 122, 122, 122, 122, 122, 122, 122
    _lowc db 64, 64, 64, 64, 64, 64, 64, 64
    _upc db 90, 90, 90, 90, 90, 90, 90, 90
    _alpha db 26, 26, 26, 26, 26, 26, 26, 26

section .text
_main:
    
    push input_text

    call _encode

    push input_text

    call _printf

    push 0
    call _exit

_encode:

    pop eax
    push ebx
    push ebp

    mov ebp, esp
    mov ebx, [ebp+8]

    pop ebp

    ; ceasar cipher with shift of 2 using mmx registers
    ; create a full mmx register with the shift value (2) repeated in each byte
    ; mask of spaces to prevent them from being changed

    push esi
    xor esi, esi
    .loop1:
        ; declaration
        movq mm0, [ebx + esi]
        pcmpeqb mm4, mm4

        movq mm1, [shift]
        punpcklbw mm1, mm1
        punpcklwd mm1, mm1
        punpcklwd mm1, mm1
        punpcklwd mm1, mm1

        ; check lower bound for uppercase
        movq mm2, [_lowc]
        movq mm3, mm0
        pcmpgtb mm3, mm2
        movq mm5, mm1
        pand mm5, mm3

        ;check upper bound for uppercase
        movq mm2, [_upc]
        movq mm3, mm0
        pcmpgtb mm3, mm2
        pxor mm3, mm4
        pand mm5, mm3

        ; check lower bound for lowercase
        movq mm2, [_low]
        movq mm3, mm0
        pcmpgtb mm3, mm2
        movq mm6, mm1
        pand mm6, mm3

        ;check upper bound for lowercase
        movq mm2, [_up]
        movq mm3, mm0
        pcmpgtb mm3, mm2
        pxor mm3, mm4
        pand mm6, mm3

        por mm5, mm6

        paddb mm0, mm5

        movq mm1, [_alpha]

        ; check upper bound for uppercase again to check for overflow
        movq mm2, [_upc]
        movq mm3, mm0
        pcmpgtb mm3, mm2
        movq mm5, mm1
        pand mm5, mm3

        movq mm2, [_low]
        movq mm3, mm0
        pcmpgtb mm3, mm2
        pxor mm3, mm4
        pand mm5, mm3

        ; check upper bound for lowercase again to check for overflow
        movq mm2, [_up]
        movq mm3, mm0
        pcmpgtb mm3, mm2
        movq mm6, mm1
        pand mm6, mm3

        por mm5, mm6

        psubb mm0, mm5
         
        movq [ebx + esi], mm0

        add esi, 8
        cmp esi, 445
        jb .loop1
    
    emms

    pop esi
    pop ebx
    push eax
ret