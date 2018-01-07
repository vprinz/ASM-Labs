; Дано два числа. Если они оба делятся на 3, то увеличить оба на 5. Иначе, если хотя бы одно оканчивается на 7, то уменьшить оба на 2.
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
    three       db 3
    ten         db 10
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
    
; Проверка на кратность 3
    mov AX, firstNum
    div three
    cmp AH, 0
    JNE A1                      ; Если не кратен, то на метку A1
        mov AX, secondNum
        div three
        cmp AH, 0
        JNE A1                  ; Если не кратен, то на метку A1

; Увеличение чисел на 5
            mov AX, firstNum
            add AX, 5           
            mov BX, secondNum
            add BX, 5
            
; Вывод ответа
            outint AX
            newline
            outint BX
            JMP A3

; Переход на метку A1, если оба числа не кратны 3. Проверка, оканчивается ли хотя бы одно число на 7
A1:
    mov AX, firstNum
    div ten
    cmp AH, 7
    JNE A2
        mov AX, firstNum
        sub AX, 2
        mov BX, secondNum
        sub BX, 2
        
; Вывод ответа
        outint AX
        newline
        outint BX
        JMP A3

A2:
    mov AX, secondNum
    div ten
    cmp AH, 7
    JNE A3
        mov AX, firstNum
        sub AX, 2
        mov BX, secondNum
        sub BX, 2

; Вывод ответа
        outint AX
        newline
        outint BX
        JMP A3

; Переход на метку A3, если никаких изменений не произошло.
A3:
    lea dx, MsgAnswer
    outstr
;================ Code above ================
    pop ax
    pop ds
Exit:
    finish
ENDS

END Start