; Является ли массив знакочередующимся?
; 1 - Да. 0 - Нет.
%TITLE ""
INCLUDE IO.ASM

LOCALS  __

MODEL   small

ST1 SEGMENT
    DB 128 DUP(?)
ST1 ENDS

DATA SEGMENT
    arr              dw  100 DUP(?)
    N                dw  ?
    answer           dw  ?
DATA ENDS


CODE SEGMENT
ASSUME SS:ST1,DS:DATA,CS:CODE

Start:
    push    ds
    push    ax
    mov ax, data    
    mov ds, ax
;================ Code below ================
; Ввод массива
    inint N
    mov CX, N
    mov BX, 0       ; Индекс элемента
A1:
    inint arr[BX]
    add BX, 2
    LOOP    A1
    
    mov CX, N
    mov answer, 1
    dec CX
    mov BX, 0
A2:
    mov DX, 0
    mov AX, arr[BX]
    add BX, 2
    mul arr[BX]     ; arr[BX] * arr[BX+2]
    cmp AX, 0
    JLE A3          ; <= 0
        mov answer, 0

A3:
    LOOP    A2
    
    outint answer
;================ Code above ================
    pop ax
    pop ds
Exit:
    finish
ENDS

END Start