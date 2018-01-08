; Дан массив. Если в массиве все элементы четные, то заменить все 2-ки значением максимального.
%TITLE ""
INCLUDE IO.ASM

LOCALS  __

MODEL   small

ST1 SEGMENT
    DB 128 DUP(?)
ST1 ENDS

DATA SEGMENT
    arr         dw  100 DUP(?)
    N           dw  ?
    two         db  2            
    max         dw  ?
    allEven     dw  1   ; Все элементы массива четные: 1 - Да, 0 - Нет.
    MsgAnswer   db  'No changes. $'
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

; Присваиваем max первый элемент массива
    mov BX, 0
    mov AX, arr[BX]
    mov max, AX
    
; Начинаем искать максимальный элемент
    mov BX, 2
    mov CX, N
    dec CX
searchMax:
    mov AX, max
    cmp arr[BX], AX
    JL next_searchMax     ; Если arr[BX] < max, то переход на next
        mov AX, arr[BX]
        mov max, AX
    next_searchMax:
        add BX, 2
LOOP    searchMax
    
; Начинаем проверять все ли элементы чётные
    mov BX, 0
    mov CX, N
    dec CX
checkEven:
    mov AX, arr[BX]
    div two
    cmp AH, 0
    JE next_checkEven
        mov allEven, 0
    next_checkEven:
        add BX, 2
LOOP    checkEven

; Заменяем все 2-ки максимальным элементом
    cmp allEven, 1
    JNE finishTask
        mov BX, 0
        mov CX, N
        dec CX
    replaceElem:
        mov AX, arr[BX]
        cmp AX, 2
        JNE next_replaceElem
            mov AX, max
            mov arr[BX], AX
        next_replaceElem:
            add BX, 2
    LOOP    replaceElem

; Вывод изменившегося массива
    mov BX, 0
    mov CX, N
outputArr:
    outint arr[BX], 4
    add BX, 2
LOOP    outputArr

; Вывод ответа о том, что массив не был изменен
finishTask:
    lea dx, MsgAnswer
    outstr
;================ Code above ================
    pop ax
    pop ds
Exit:
    finish
ENDS

END Start