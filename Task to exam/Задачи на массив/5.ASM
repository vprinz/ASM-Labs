; Сколько положительных элементов в массиве до первого отрицательного.
%TITLE ""
INCLUDE IO.ASM

LOCALS  __

MODEL   small

ST1 SEGMENT
    DB 128 DUP(?)
ST1 ENDS

DATA SEGMENT
    arr     dw  100 DUP(?)
    N       dw  ?
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
inputArr:
    inint arr[BX]
    add BX, 2
LOOP    inputArr

    mov CX, N
    mov BX, 0
    mov AX, 0   ; counter
check:
    cmp arr[BX], 0
    JL endProg
        inc AX
    check_next:
        add BX, 2
LOOP    check

endProg:
    outint AX    
;================ Code above ================
    pop ax
    pop ds
Exit:
    finish
ENDS

END Start