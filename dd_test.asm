
; Attempt to run:
; dd if=/dev/null of=/dev/stdout count=1 bs=1
; using sys call:



; sys call    |    rdi                |     rsi                   |      rdx
; ------------|-----------------------|---------------------------|---------------------------
; sys_execve  |	const char *filename  |	const char *const argv[]  | const char *const envp[]


; Build and link:
; nasm -felf64 dd_test.asm && ld dd_test.o && ./a.out


;
; CONSTANTS
;
SYS_EXECVE   equ 59
SYS_EXIT     equ 60
STDOUT       equ 1


global _start

;
; Initialised data goes here
;
SECTION .data
filename            db  "/bin/dd",0      ; char *

arg1                db  "if=/dev/null",0
arg2                db  "of=/dev/stdout",0
arg3                db  "count=1",0
arg4                db  "bs=1",0

argv                dq  arg1, arg2, arg3, arg4


;
; Code goes here
;
SECTION .text

_start:
    ; syscall(SYS_EXECVE, filename, argv, envp);
    mov     rax, SYS_EXECVE
    mov     rdi, filename
    mov     rsi, argv
    mov     rdx, 0
    syscall
    mov     rax, rdi ; return value

    ; syscall(SYS_EXIT)
    mov     rax, SYS_EXIT
    syscall

