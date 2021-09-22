; build:
; nasm -felf64 -o hello64_libc.o hello64_libc.asm
; 
; link:
; gcc -o hello64_libc hello64_libc.o
;

extern printf

section .rodata
hello           db  "Finally Works!", 10, 0 ; const char *
hello_len       equ $ - hello               ; size_t

section .text
global main
main:
    mov rdi, hello
    xor rax, rax
    call printf wrt ..plt
    ret

