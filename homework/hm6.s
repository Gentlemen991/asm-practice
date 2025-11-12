SortData PROC
    pushad

    push ecx
    push edi

    rep movsb
    
    pop edi
    pop eax
    
    xor edx, edx
    div ebx

    dec eax
    jz .sort_exit
    
    mov ecx, eax

.outer_loop:
    push ecx
    mov esi, edi
    
    cmp ebx, 1
    je .inner_loop_byte
    cmp ebx, 2
    je .inner_loop_word
    cmp ebx, 4
    je .inner_loop_dword
    cmp ebx, 8
    je .inner_loop_qword
    
    jmp .end_inner_loop 

.inner_loop_byte:
    mov al, [esi]
    cmp al, [esi+1]
    jle .no_swap_byte
    xchg al, [esi+1]
    mov [esi], al
.no_swap_byte:
    add esi, 1
    loop .inner_loop_byte
    jmp .end_inner_loop

.inner_loop_word:
    mov ax, [esi]
    cmp ax, [esi+2]
    jle .no_swap_word
    xchg ax, [esi+2]
    mov [esi], ax
.no_swap_word:
    add esi, 2
    loop .inner_loop_word
    jmp .end_inner_loop

.inner_loop_dword:
    mov eax, [esi]
    cmp eax, [esi+4]
    jle .no_swap_dword
    xchg eax, [esi+4]
    mov [esi], eax
.no_swap_dword:
    add esi, 4
    loop .inner_loop_dword
    jmp .end_inner_loop

.inner_loop_qword:
    mov eax, [esi+4]
    cmp eax, [esi+8+4]
    jl .no_swap_qword
    jg .do_swap_qword
    
    mov eax, [esi]
    cmp eax, [esi+8]
    jle .no_swap_qword
    
.do_swap_qword:
    mov eax, [esi]
    mov edx, [esi+4]
    
    mov ebp, [esi+8]
    mov [esi], ebp
    mov ebp, [esi+8+4]
    mov [esi+4], ebp
    
    mov [esi+8], eax
    mov [esi+8+4], edx
    
.no_swap_qword:
    add esi, 8
    loop .inner_loop_qword

.end_inner_loop:
    pop ecx
    dec ecx
    jnz .outer_loop

.sort_exit:
    popad
    ret

SortData ENDP