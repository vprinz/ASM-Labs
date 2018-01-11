; Дана матрица. Найти максимальный элемент главной диагонали.
%TITLE ""
INCLUDE IO.ASM

LOCALS  __

MODEL   small

ST1 SEGMENT
    DB 128 DUP(?)
ST1 ENDS

DATA SEGMENT
    arr dw  256 DUP(?)
    N   dw  ?
DATA ENDS


CODE SEGMENT
ASSUME SS:ST1,DS:DATA,CS:CODE

Start:
    push    ds
    push    ax
    mov ax, data    
    mov ds, ax
;================ Code below ================

; Ввод матрицы
    inint N
    mov CX, N
    mov BX, 0
inputArr:
    push CX
    mov CX, N
    mov SI, 0   ; Регистр, отвечающий за столбец
inputArr_Elem:
    inint arr[BX][SI]
    add SI, 2
LOOP    inputArr_Elem
    add BX, N
    add BX, N
    pop CX
LOOP    inputArr

    mov CX, N
    mov BX, 0
searchMax:
    mov AX, arr[0]
    cmp arr[BX], AX
    JLE searchMax_next
        mov AX, arr[BX]
    searchMax_next:
        add BX, N
        add BX, N
LOOP searchMax

    outint AX
;================ Code above ================
    pop ax
    pop ds
Exit:
    finish
ENDS

END Start