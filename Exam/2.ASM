; Подсчитать количество монотонно возрастающих отрезков в массиве.

%TITLE ""
INCLUDE IO.ASM

LOCALS  __

MODEL   small

ST1 SEGMENT
    DB 128 DUP(?)
ST1 ENDS

DATA SEGMENT
    arr             dw  100 DUP(?)
    N               dw  ?
    amount          dw  ?
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
; Ввод массива
    inint N
    mov CX, N
    mov BX, 0
inputArr:
    inint arr[BX]
    add BX, 2
LOOP    inputArr

    mov CX, N
    mov BX, 0
    mov amount, 0
amountSegment:
    mov AX, arr[BX+2]
    cmp AX, arr[BX]
    JL amountSegment_next   ;   arr[BX+2] < arr[BX]
        inc amount
    amountSegment_next:
        add BX, 2
LOOP    amountSegment
    
    lea dx, MsgAnswer
    outstr
    outint amount
;================ Code above ================
    pop ax
    pop ds
Exit:
    finish
ENDS

END Start