; 32-bit MS COFF
%define int_21h call _interupt_21h ; Alias to simulate DOS interrupt behavior
global  _main
extern  _interupt_21h
extern _scanf
extern _printf


section .data
    x dq 1.0 ;initial guess
    S dq 0.0 ;Input

    half dq 0.5
    fmt db "%lf", 0

section .text
_main:

    call _input

    call heron

    call _output

    ; Exit program with return code 0 (AH=00h)
    mov ah, 0
    mov al, 0 ; Set return code to 0
    int_21h

    _input:
        mov edx, S
        push edx
        mov edx, fmt
        push edx

        call _scanf
        add esp, 8
    ret

    _output:
        mov edx, [x + 4]
        push edx

        mov edx, [x]
        push edx

        mov edx, fmt
        push edx

        call _printf
        add esp, 12
    ret

    heron:
        mov ecx, 10

        .loop1:
            fninit
            fld qword [half]
            fld qword [S]
            fld qword [x]
            
            fdiv
            fld qword [x]

            fadd
            fmul
            fst qword [x]

            loop .loop1
    ret
