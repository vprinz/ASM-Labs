; Дано два числа. Найти наибольшее.
%TITLE ""
INCLUDE IO.ASM

LOCALS  __

MODEL   small

ST1 SEGMENT
    DB 128 DUP(?)
ST1 ENDS

DATA SEGMENT
    
DATA ENDS


CODE SEGMENT
ASSUME SS:ST1,DS:DATA,CS:CODE

Start:
    push    ds
    push    ax
    mov ax, data    
    mov ds, ax
;================ Code below ================
    inint AX
    inint BX
    
    cmp AX, BX
    JL A1           ; Если AX < BX, то переход к метки A1
        outint AX
        JMP A2      ; Переход на метку A2, чтобы не вывелось два числа
A1:
    outint BX
A2:
;================ Code above ================
    pop ax
    pop ds
Exit:
    finish
ENDS

END Start