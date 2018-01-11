; Сочетание из n по k: n! / (n-k)! * k!
%TITLE ""
INCLUDE IO.ASM

LOCALS  __

MODEL   small

ST1 SEGMENT
    DB 128 DUP(?)
ST1 ENDS

DATA SEGMENT
    n       dw  ?
    k       dw  ?
    first   dw  ?
    second  dw  ?
    third   dw  ?
DATA ENDS


CODE SEGMENT
ASSUME SS:ST1,DS:DATA,CS:CODE

fact proc
; AX - возвращаемое значение
   mov AX, 1
   mov BX, 1
calc:
    mul BX
    inc BX
LOOP    calc
    ret
fact endp

Start:
    push    ds
    push    ax
    mov ax, data    
    mov ds, ax
;================ Code below ================
    inint n
    inint k
    
    mov CX, n   ; считаем n!
    call fact
    mov first, AX
    
    mov CX, n   ; считаем (n-k)!
    sub CX, k
    call fact
    mov second, AX
    
    mov CX, k   ; считаем k!
    call fact
    mov third, AX
    
    mov AX, second
    mul third
    
    mov BX, AX
    
    mov AX, first
    div BX
    
    outint AX
;================ Code above ================
    pop ax
    pop ds
Exit:
    finish
ENDS

END Start