section .data
msg:    db  "Hello, world!", 10   ;
len     equ $ - msg               ;

section .text
global _start

_start:
    ; write(1, msg, len)
    mov     rax, 1        ; syscall: sys_write
    mov     rdi, 1        ; fd = 1 (stdout)
    lea     rsi, [rel msg]; pointer to msg
    mov     rdx, len      ; length
    syscall

    ; exit(0)
    mov     rax, 60       ; syscall: sys_exit
    xor     rdi, rdi      ; status = 0
    syscall