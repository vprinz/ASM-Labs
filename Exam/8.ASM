; Сочетание из n по k: n! / (n-k)! * k!

%TITLE ""
INCLUDE IO.ASM

MODEL   small

ST1 SEGMENT
    DB 128 DUP(?)
ST1 ENDS

DATA SEGMENT
    n dw ?
    k dw ?
    first dw ?
    second dw ?
    third dw ?
DATA ENDS

CODE SEGMENT
ASSUME SS:ST1,DS:DATA,CS:CODE

fact proc
    ; cx - предел (n или k)
    ; ax - возвращаемое значение

    mov ax, 1
    jcxz return ; 0! = 1

    mov bx, 1 ; текущий факториал
calc:
    mul bx
    inc bx
loop calc

return:
    ret
fact endp

Start:
    push    ds
    push    ax
    mov ax, data    
    mov ds, ax
;========== Put your code below ==============================
; Сочетание из n по k: n! / (n-k)! * k!

    inint n
    inint k

    mov cx, n ; считаем n!
    call fact
    mov first, ax

    mov cx, n ; считаем (n-k)!
    sub cx, k
    call fact
    mov second, ax

    mov cx, k
    call fact
    mov third, ax

    mov ax, second
    mul third

    mov bx, ax

    mov ax, first
    div bx

    outint ax
    
;========== End of your code block ===========================
    pop ax
    pop ds
Exit:
    finish
ENDS

END Start