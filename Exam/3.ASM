; Найти минимальное положительное число в матрице, сумма индексов которого четная

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
    two             db  2
    min             dw  ?
    MsgAnswer       db  'Answer: $'
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
inputRow:
    push CX     ; Поместить CX в стек
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

; Поиск минимального
    mov AX, matrix[0][0]
    mov min, AX
    mov CX, N
    mov BX, 0
checkRow:
    push CX
    mov CX, N
    mov SI, 0
    checkCol:
        mov AX, BX
        add AX, SI
        div two
        cmp AH, 0
        jne checkNext
            mov AX, matrix[BX][SI]
            cmp AX, min
            JG  checkNext
                mov min, AX
        checkNext:
            add SI, 2
    LOOP    checkCol
    add BX, N
    add BX, N
    pop CX
LOOP    checkRow

    lea DX, MsgAnswer
    outstr
    outint min        
;================ Code above ================
    pop ax
    pop ds
Exit:
    finish
ENDS

END Start