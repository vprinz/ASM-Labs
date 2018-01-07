; Дано два числа. Если одно хотя бы положительо, то найти их разность. 
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
    MsgAnswer   db 'No changes. $'
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
    
    cmp firstNum, 0
    JG A1
        cmp secondNum, 0
        JG A1
        jmp A2
A1:
    mov AX, firstNum
    sub AX, secondNum
    outint AX
    
A2:
    lea dx, MsgAnswer
    outstr
;================ Code above ================
    pop ax
    pop ds
Exit:
    finish
ENDS

END Start