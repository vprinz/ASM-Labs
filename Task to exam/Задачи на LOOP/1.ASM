; Дано N чисел. Найти сумму четных.
%TITLE ""
INCLUDE IO.ASM

LOCALS  __

MODEL   small

ST1 SEGMENT
    DB 128 DUP(?)
ST1 ENDS

DATA SEGMENT
    N   dw ?
    x   dw ?
    two db 2
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
    mov CX, N
    mov BX, 0    
A1:
    inint x
    mov AX, x
    div two
    cmp AH, 0
    JNE A2
        add BX, x

A2:
    LOOP    A1
    
    outint BX
;================ Code above ================
    pop ax
    pop ds
Exit:
    finish
ENDS

END Start