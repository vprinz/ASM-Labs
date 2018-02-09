; Найти сумму максимальных элементов каждой строки в квадратной матрице

%TITLE ""
INCLUDE IO.ASM

LOCALS  __

MODEL   small

ST1 SEGMENT
    DB 128 DUP(?)
ST1 ENDS

DATA SEGMENT
    matrix          dw  20 DUP(20 DUP (?))
    N               dw  ?
    max             dw  ?
    MsgAnswer       db  'Answer: $'
    InputN          db  'Input matrix size: $'
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
    lea dx, inputN
    outstr
    inint N
    mov CX, N
    mov BX, 0
inputRow:
    push CX
    mov CX, N
    mov SI, 0
    inputCol:
        inint matrix[BX][SI]
        add SI, 2
    LOOP    inputCol
    add BX, N
    add BX, N
    pop CX
LOOP    inputRow

; Считаем сумму каждой строки

    mov CX, N
    mov BX, 0
    mov max, 0
startProg:
    push CX
    mov CX, N
    mov SI, 0
    mov DX, matrix[BX][0]
    calcSum:
        mov AX, matrix[BX][SI]
        cmp AX, DX
        JL next                 ; AX < DX  | matrix[BX][SI] < DX
            mov DX, AX          ; DX := AX | DX := matrix[BX][SI]
        next:
            add SI, 2
    LOOP    calcSum
    add max, DX
    add BX, N
    add BX, N
    pop CX
LOOP    startProg

    lea dx, MsgAnswer
    outstr
    outint max
;================ Code above ================
    pop ax
    pop ds
Exit:
    finish
ENDS

END Start