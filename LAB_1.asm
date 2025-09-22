.model small
.stack 100h

.data
    a dw 15
    b dw 3
    sum dw ?
    diff dw ?
    prod dw ?
    quot dw ?
    rem dw ?

    msg1 db 'Sum = $'
    msg2 db 0Dh,0Ah,'Diff = $'
    msg3 db 0Dh,0Ah,'Prod = $'
    msg4 db 0Dh,0Ah,'Quot = $'
    msg5 db 0Dh,0Ah,'Rem  = $',0Dh,0Ah,'$'

.code
main:
    mov ax, @data
    mov ds, ax

    ; Додавання
    mov ax, a
    add ax, b
    mov sum, ax

    ; Віднімання
    mov ax, a
    sub ax, b
    mov diff, ax

    ; Множення
    mov ax, a
    mov bx, b
    mul bx
    mov prod, ax

    ; Ділення
    mov ax, a
    cwd
    mov bx, b
    div bx
    mov quot, ax
    mov rem, dx

    ; Вивід результатів
    mov dx, offset msg1
    mov ah, 9
    int 21h
    mov ax, sum
    call print_number

    mov dx, offset msg2
    mov ah, 9
    int 21h
    mov ax, diff
    call print_number

    mov dx, offset msg3
    mov ah, 9
    int 21h
    mov ax, prod
    call print_number

    mov dx, offset msg4
    mov ah, 9
    int 21h
    mov ax, quot
    call print_number

    mov dx, offset msg5
    mov ah, 9
    int 21h
    mov ax, rem
    call print_number

    ; Завершення
    mov ax, 4C00h
    int 21h


; ----------------------------
; Процедура виводу числа AX
; ----------------------------
print_number proc
    push ax
    push bx
    push cx
    push dx

    xor cx, cx
    mov bx, 10

conv_loop:
    xor dx, dx
    div bx          ; AX / 10 ? AX=частка, DX=остача
    push dx         ; зберігаємо цифру
    inc cx
    test ax, ax
    jnz conv_loop

print_loop:
    pop dx
    add dl, '0'
    mov ah, 2
    int 21h
    loop print_loop

    ret
print_number endp

end main
