![MTECH_GPIO](logo.png)

---

# MTECH_EMU_DOS_NASM

A starter template for learning x86 (32-bit) assembly at **Montana Technological University**. This project provides a pre-configured environment to write, build, and debug assembly programs using a simulated DOS-like interrupt interface.

## Project Structure

* `src/main.asm`: Your main assembly source file.
* `lib/`: Contains the necessary tools and libraries:
    * `interupt.obj`: The DOS interrupt emulator ([MTECH_INT_DOS](https://github.com/jpach-cs/MTECH_INT_DOS)).
    * `lld-link.exe`: The LLVM linker.
    * `msvcrt.lib` & `kernel32.lib`: Microsoft C and System libraries.
* `build32/`: Output directory for compiled binaries (`.exe`, `.obj`, `.pdb`).

## Prerequisites

To use this template, you must have the following installed on your system:

1.  **NASM Compiler**: Ensure it is installed at `C:\Program Files\nasm\nasm.exe` or update the path in the `Makefile`.
2.  **Make Utility**: (e.g., `mingw32-make`) added to your system PATH.
3.  **VS Code Extensions**: We recommend the "C/C++" extension for debugging support.

## Getting Started

### 1. Building the Project
Open your terminal in the project root and run:
```bash
mingw32-make
```

### 2. Usage Example
The project comes with an example in src/main.asm. It uses an alias to simulate classic DOS interrupts:

```x86asm
%define int_21h call _interupt_21h

section .data
    msg db "Hello from NASM!", 0

section .text
    global _main
_main:
    mov ah, 9       ; DOS Function: Print String
    mov edx, msg    ; Pointer to string
    int_21h         ; Call Emulator

    mov ah, 0       ; DOS Function: Exit
    int_21h
```

## License

MIT License © 2026 Jakub Leszek Pach, Montana Technological University

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

The software is provided "as is", without warranty of any kind. The author is not responsible for any damage or malfunction resulting from its use.