section .data
    buffer db 20 dup(0)
    newline db 10, 0

section .text
    global _start

_start:
    mov eax, 1234567
    mov esi, buffer
    call int2str

    ; вивід результату (через Linux sys_write)
    mov edx, eax
    mov ecx, buffer    
    mov ebx, 1
    mov ebx, 1
    mov eax, 4
    int 0x80

    ; вихід з програми
    mov eax, 1
    xor ebx, ebx
    int 0x80

int2str:
    push ebx
    push ecx
    push edx

    mov ebx, 10
    mov ecx, esi
    add esi, 19
    mov byte [esi], 0

.convert_loop:
    xor edx, edx
    div ebx
    add dl, '0'
    dec esi
    mov [esi], dl
    test eax, eax
    jnz .convert_loop

    mov edi, ecx
.copy_loop:
    lodsb
    stosb
    cmp al, 0
    jne .copy_loop

    mov eax, edi
    sub eax, ecx
    pop edx
    pop ecx
    pop ebx
    ret