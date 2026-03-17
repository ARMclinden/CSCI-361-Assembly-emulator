; 32-bit MS COFF
%define int_21h call _interupt_21h ; Alias to simulate DOS interrupt behavior
global  _main
extern  _interupt_21h


section .data
    ; newLine   db  10, 13, 0
     msg       db  "Hello from NASM!", 0

    ; buf       db  10             ; [0] Maximum buffer size
    ;           db  0              ; [1] Actual number of characters read
    ; times 11  db  0              ; [2..] Character data + safety padding

section .text
_main:

    ; Print message (AH=09h)
    mov ah, 9
    mov edx, msg
    int_21h
    

    ; ; Print newline (CR/LF)
    ; mov ah, 9
    ; mov edx, newLine
    ; int_21h  

    ; ; Read string into buffer (AH=0Ah)
    ; mov ah, 10
    ; mov edx, buf
    ; int_21h

    ; ; Print newline (CR/LF)
    ; mov ah, 9
    ; mov edx, newLine
    ; int_21h

    ; ; Print buffer content (AH=09h)
    ; ; Note: Skip first 2 bytes (limit and count) to reach the actual string
    ; mov ah, 9
    ; mov edx, buf + 2 
    ; int_21h   

    ; ; Print newline (CR/LF)
    ; mov ah, 9
    ; mov edx, newLine
    ; int_21h

    ; ; Print single character 'A' (AH=02h)
    ; mov ah, 2
    ; mov dl, 65 ; ASCII for 'A'
    ; int_21h

    ; ; Print newline (CR/LF)
    ; mov ah, 9
    ; mov edx, newLine
    ; int_21h

    ; ; Read single character into AL (AH=01h)
    ; mov ah, 1
    ; int_21h

    ; ; Print the character just read from AL (AH=02h)
    ; mov dl, al
    ; mov ah, 2
    ; int_21h

    ; Exit program with return code 0 (AH=00h)
    mov ah, 0
    mov al, 0 ; Set return code to 0
    int_21h