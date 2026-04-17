; 32-bit MS COFF
%define int_21h call _interupt_21h ; Alias to simulate DOS interrupt behavior
global  _main
extern  _interupt_21h
extern _scanf
extern _printf


section .data
    input_text db 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 0
    padding db 0, 0, 0, 0, 0, 0, 0, 0
    
    shift db 2 
    fmt db "%s"

section .text
_main:

    sub esp, 8
    add esp, 8
    
    call _encode

    call _print

    ; Exit program with return code 0 (AH=00h)
    mov ah, 0
    mov al, 0 ; Set return code to 0
    int_21h

_encode:
    ; ceasar cipher with shift of 2 using mmx registers
    ; create a full mmx register with the shift value (2) repeated in each byte
    movq mm1, [shift]
    punpcklbw mm1, mm1
    punpcklwd mm1, mm1
    punpcklwd mm1, mm1
    punpcklwd mm1, mm1

    ; load input text into mmx register 8 bytes at a time
    ; add 2 to each byte, wrapping to the beginning of the alphabet if necessary
    ; store the result back to memory

    xor esi, esi
    movq mm2, [padding] ; Load padding into mm2 to handle the last few bytes of input_text
    .loop1:
        movq mm0, [input_text + esi]

        

        paddb mm0, mm7

        movq [input_text + esi], mm0

        add esi, 8
        cmp esi, 445
        jb .loop1
ret
_print:
    pop eax
    ; push encoded text onto the stack 4 bytes at at time
    xor esi, esi
    mov esi, 444
    xor edx, edx
    push edx

    .loop2:
        push [input_text + esi]

        sub esi, 4
        cmp esi, 0
        ja .loop2
    
    push fmt
    
    call _printf

    push eax
ret