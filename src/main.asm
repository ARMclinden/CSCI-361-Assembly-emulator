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

    mov edx, S
    push edx

    call _input

    push eax
    mov eax, x
    push eax

    call heron

    fst [S]
    mov edx, S
    push eax

    call _output

    ; Exit program with return code 0 (AH=00h)
    mov ah, 0
    mov al, 0 ; Set return code to 0
    int_21h

    _input:
        push ebp
        mov ebp, esp
        mov edx, [ebp+8]
        push edx
        mov edx, fmt
        push edx

        call _scanf
        add esp, 8
        mov eax, [ebp+8]
        pop ebp
    ret

    _output:
        push ebx
        push ebp
        mov ebp, esp
        mov ebx, [ebp+12]

        mov edx, [ebx + 4]
        push edx

        mov edx, [ebx]
        push edx

        mov edx, fmt
        push edx

        call _printf
        add esp, 12
        pop ebp
        pop ebx
    ret

    heron:
        pop ecx
        pop eax
        pop edx
        push ecx
        push ebx

        mov ecx, 10

        .loop1:
            fninit
            fld qword [half]
            mov ebx, edx
            fld qword [ebx]
            mov ebx, eax
            fld qword [ebx]
            
            fdiv
            fld qword [ebx]

            fadd
            fmul
            fst qword [ebx]

            loop .loop1
        pop ebx
    ret
