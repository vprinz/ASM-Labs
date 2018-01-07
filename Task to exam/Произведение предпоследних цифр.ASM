; Даны два числа. Найти произвдение их предпоследних цифр.
%TITLE ""
INCLUDE IO.ASM

LOCALS  __

MODEL   small

ST1 SEGMENT
    DB 128 DUP(?)
ST1 ENDS

DATA SEGMENT
    firstNum       dw ?
    secondNum      dw ?
    x              db 0
    y              db 0
    ten            db 10
DATA ENDS


CODE SEGMENT
ASSUME SS:ST1,DS:DATA,CS:CODE

Start:
    push    ds
    push    ax
    mov ax, data    
    mov ds, ax
;================ Code below ================
    inint firstNum  ; Вводим число 123
    inint secondNum ; Вводим число 456
    
; Вычисляем предпоследнюю цифру числа 123
    mov AX, firstNum
    div ten
    mov AH, 0
    div ten
    mov x, AH   ; Заносим в x число 2
    
; Вычисляем предпоследнюю цифру числа 456
    mov AX, secondNum
    div ten
    mov AH, 0
    div ten
    mov y, AH   ; Заносим в y число 5

; Умножаем полученные цифры между собой
    mov AX, 0
    mov AL, x
    mul y
    
    outint AX
;================ Code above ================
    pop ax
    pop ds
Exit:
    finish
ENDS

END Start