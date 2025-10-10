.model small
.stack 100h
.data
    msgPrime db "Число є простим.$"
    msgNotPrime db "Число не є простим.$"
    msgNumber db "Введене число: $"

.code
main proc
    mov ax, @data
    mov ds, ax

    mov ax, 13      
    mov bx, ax        

    lea dx, msgNumber
    mov ah, 9
    int 21h

    call printNumber

    mov ax, bx       
    call isPrime

    mov ah, 4Ch
    int 21h
main endp

isPrime proc
    mov cx, 2
    mov dx, 0

check_loop:
    mov bx, cx
    cmp bx, ax
    jge prime    

    mov dx, 0
    div bx
    cmp dx, 0
    je not_prime  

    inc cx
    jmp check_loop

prime:
    lea dx, msgPrime
    mov ah, 9
    int 21h
    ret

not_prime:
    lea dx, msgNotPrime
    mov ah, 9
    int 21h
    ret
isPrime endp

printNumber proc
    push ax
    push bx
    push cx
    push dx

    mov cx, 0
    mov bx, 10

convert_loop:
    xor dx, dx
    div bx
    push dx
    inc cx
    test ax, ax
    jnz convert_loop

print_loop:
    pop dx
    add dl, '0'
    mov ah, 2
    int 21h
    loop print_loop

    mov dl, 13
    mov ah, 2
    int 21h
    mov dl, 10
    int 21h

    pop dx
    pop cx
    pop bx
    pop ax
    ret
printNumber endp

end main