.model small
.stack 100h

.data
    input_msg db 'Input number: $'
    result_msg db 'Factorial: $'
    newline db 13, 10, '$'
    buffer db 6 dup('$')
    
.code

main proc
    mov ax, @data
    mov ds, ax
    
    mov ax, 5
    call print_input_number
    call factorial_iterative
    call print_result
    
    mov ah, 4Ch
    int 21h
main endp

factorial_iterative proc
    push bx
    push cx
    
    mov cx, ax
    mov ax, 1
    mov dx, 0
    
    cmp cx, 0
    je done_iter
    
    mov bx, 1
    
multiply_loop:
    mul bx
    inc bx
    cmp bx, cx
    jle multiply_loop
    
done_iter:
    pop cx
    pop bx
    ret
factorial_iterative endp

print_input_number proc
    push ax
    push dx
    
    lea dx, input_msg
    mov ah, 09h
    int 21h
    
    pop dx
    pop ax
    
    call number_to_string
    mov ah, 09h
    lea dx, buffer
    int 21h
    
    lea dx, newline
    mov ah, 09h
    int 21h
    
    ret
print_input_number endp

print_result proc
    push ax
    push dx
    
    lea dx, result_msg
    mov ah, 09h
    int 21h
    
    pop dx
    pop ax
    
    call print_dx_ax_number
    
    lea dx, newline
    mov ah, 09h
    int 21h
    
    ret
print_result endp

number_to_string proc
    push ax
    push bx
    push cx
    push dx
    push si
    
    lea si, buffer + 5
    mov byte ptr [si], '$'
    mov bx, 10
    mov cx, ax
    
convert_loop:
    dec si
    xor dx, dx
    mov ax, cx
    div bx
    mov cx, ax
    add dl, '0'
    mov [si], dl
    test cx, cx
    jnz convert_loop
    
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
number_to_string endp

print_dx_ax_number proc
    push ax
    push bx
    push cx
    push dx
    
    call number_to_string
    mov ah, 09h
    lea dx, buffer
    int 21h
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_dx_ax_number endp

end main
