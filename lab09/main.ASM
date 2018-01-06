%TITLE ""
INCLUDE IO.ASM

LOCALS  __

MODEL   small

ST1 SEGMENT
    DB 128 DUP(?)
ST1 ENDS

DATA SEGMENT
    MsgNum  db  'Enter number: $'
    MsgSqr  db  'a^2 = $'

    number  dw  0
DATA ENDS


CODE SEGMENT
ASSUME SS:ST1,DS:DATA,CS:CODE

sqr     macro   num
    mov     ax, num
    mul     num
endm

Start:
    push    ds
    push    ax
    mov ax, data    
    mov ds, ax
;================ Code below ================
    lea     dx, MsgNum
    outstr
    inint   number

    sqr     number
    lea     dx, MsgSqr
    outstr
    outint  ax
;================ Code above ================
    pop ax
    pop ds
Exit:
    finish
ENDS

END Start