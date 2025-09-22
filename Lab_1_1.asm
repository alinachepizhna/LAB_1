.MODEL SMALL
.STACK 100h

.DATA
    ; Два дійсних числа для демонстрації
    A DD 5.5
    B DD 2.2

    SUM DD ?       ; Результат додавання
    DIFF DD ?      ; Результат віднімання
    PROD DD ?      ; Результат множення
    QUOT DD ?      ; Результат ділення

    msgSum DB 'Sum = $'
    msgDiff DB 0Dh,0Ah,'Diff = $'
    msgProd DB 0Dh,0Ah,'Prod = $'
    msgQuot DB 0Dh,0Ah,'Quot = $',0Dh,0Ah,'$'

.CODE
START:
    mov ax,@data
    mov ds,ax

    ; Ініціалізація FPU
    FINIT

    ; --- Додавання ---
    fld DWORD PTR A     ; завантажуємо A в ST(0)
    fadd DWORD PTR B    ; додаємо B → ST(0)
    fstp DWORD PTR SUM  ; зберігаємо результат в SUM

    ; --- Віднімання ---
    fld DWORD PTR A
    fsub DWORD PTR B
    fstp DWORD PTR DIFF

    ; --- Множення ---
    fld DWORD PTR A
    fmul DWORD PTR B
    fstp DWORD PTR PROD

    ; --- Ділення ---
    fld DWORD PTR A
    fdiv DWORD PTR B
    fstp DWORD PTR QUOT

    ; --- Вивід повідомлень ---
    mov dx, offset msgSum
    mov ah, 9
    int 21h

    ; Вивід результатів можна зробити через FPU → ASCII,
    ; для простоти залишимо збереження в пам'яті
    ; їх можна перевірити через відладчик

    mov dx, offset msgDiff
    mov ah, 9
    int 21h

    mov dx, offset msgProd
    mov ah, 9
    int 21h

    mov dx, offset msgQuot
    mov ah, 9
    int 21h

    ; Завершення програми
    mov ax, 4C00h
    int 21h

END START
