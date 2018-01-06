; Дано число. Найти квадрат его второй цифры.
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
    hundred db 100
DATA ENDS


CODE SEGMENT
ASSUME SS:ST1,DS:DATA,CS:CODE

Start:
    push    ds
    push    ax
    mov ax, data    
    mov ds, ax
;================ Code below ================
    inint N
    
    mov AX, N
    div hundred
    mov AH, 0   ; Оставляем толкьо целую часть, то есть 12
    div ten
    mov x, AH   ; Заносим в x число 2
    mov AX, 0
    mov AL, x
    mul x
    
    outint AX
;================ Code above ================
    pop ax
    pop ds
Exit:
    finish
ENDS

END Start