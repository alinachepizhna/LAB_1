.model small
.stack 100h

.data
a dw 15           ; Перше число
b dw 3            ; Друге число
sum dw ?          ; Сума a + b
diff dw ?         ; Різниця a - b
prod dw ?         ; Добуток a * b
quot dw ?         ; Частка a / b
rem dw ?          ; Решта від ділення a / b

msg1 db 'Sum = $'               ; Текст для виводу суми
msg2 db 0Dh,0Ah,'Diff = $'      ; Текст для виводу різниці
msg3 db 0Dh,0Ah,'Prod = $'      ; Текст для виводу добутку
msg4 db 0Dh,0Ah,'Quot = $'      ; Текст для виводу частки
msg5 db 0Dh,0Ah,'Rem  = $',0Dh,0Ah,'$'  ; Текст для виводу остачі

buf db '00000$'       ; Буфер для конвертації числа в ASCII

.code
main:
    mov ax, @data
    mov ds, ax          ; Ініціалізація сегмента даних

    ; ---------------------------
    ; Обчислення суми
    mov ax, a
    add ax, b
    mov sum, ax

    ; ---------------------------
    ; Обчислення різниці
    mov ax, a
    sub ax, b
    mov diff, ax

    ; ---------------------------
    ; Обчислення добутку
    mov ax, a
    mov bx, b
    mul bx
    mov prod, ax

    ; ---------------------------
    ; Обчислення частки та остачі
    mov ax, a
    cwd                 ; Розширюємо AX у DX:AX для ділення
    mov bx, b
    div bx
    mov quot, ax
    mov rem, dx

    ; ---------------------------
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

    ; ---------------------------
    ; Завершення програми
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

    mov cx, 0          ; Лічильник цифр
    mov bx, 10         ; Основа для ділення (десяткова)
    cmp ax, 0
    jne conv_loop
    ; Якщо число 0
    mov dl, '0'
    mov ah, 2
    int 21h
    jmp print_done

conv_loop:
    xor dx, dx
    div bx              ; AX / 10 → AX = частка, DX = остача
    push dx             ; Зберігаємо цифру на стек
    inc cx
    cmp ax, 0
    jne conv_loop

print_loop:
    pop dx
    add dl, '0'         ; Перетворюємо цифру в ASCII
    mov ah, 2
    int 21h             ; Виводимо символ
    loop print_loop

print_done:
    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_number endp

end main
