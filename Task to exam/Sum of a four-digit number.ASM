; Сумма цифр 4-го числа.
%TITLE ""
INCLUDE IO.ASM

LOCALS  __

MODEL   small

ST1 SEGMENT
    DB 128 DUP(?)
ST1 ENDS

DATA SEGMENT
    N       dw ?
    x       db 0
    ten     db 10
DATA ENDS


CODE SEGMENT
ASSUME SS:ST1,DS:DATA,CS:CODE

Start:
    push    ds
    push    ax
    mov ax, data    
    mov ds, ax
;================ Code below ================
    inint N     ; Вводим число 1234
    mov AX, N
    div ten
    mov x, AH   ; Заносим в x число 4
    mov AH, 0
    div ten
    add x, AH   ; Суммируем х с AH (то есть 4 + 3 = 7)
    mov AH, 0
    div ten
    add x, AH   ; Суммируем х с AH (то есть 7 + 2 = 9)
    add x, AL   ; Суммируем х с AL (то есть 9 + 1 = 10)
    mov AH, 0
    mov AL, x
    outint AX
;================ Code above ================
    pop ax
    pop ds
Exit:
    finish
ENDS

END Start