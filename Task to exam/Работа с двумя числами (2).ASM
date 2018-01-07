; Дано два числа. Если первое четное, а второе кратно 5, то найти их сумму. Иначе их произведение.
%TITLE ""
INCLUDE IO.ASM

LOCALS  __

MODEL   small

ST1 SEGMENT
    DB 128 DUP(?)
ST1 ENDS

DATA SEGMENT
    firstNum    dw ?
    secondNum   dw ?
    two         db 2
    five        db 5
DATA ENDS


CODE SEGMENT
ASSUME SS:ST1,DS:DATA,CS:CODE

Start:
    push    ds
    push    ax
    mov ax, data    
    mov ds, ax
;================ Code below ================
    inint firstNum
    inint secondNum
    
    mov AX, firstNum
    div two
    cmp AH, 0
    JNE A1
        mov AX, secondNum
        div five
        cmp AH, 0
        JNE A1
            mov AX, firstNum
            add AX, secondNum
            outint AX
            JMP A3

A1:
    mov AX, firstNum
    mul secondNum
    outint AX

A3:
;================ Code above ================
    pop ax
    pop ds
Exit:
    finish
ENDS

END Start