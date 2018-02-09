; Дан массив размерностью N. Найти максимальное количество повторений его элементов.
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
    max     dw  ?
    tempMax dw  ?   ; Временный максимум
    MsgAnswer   db  'Answer: $'
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

; Сортируем массив по возрастанию
    mov SI, 0
    mov CX, N
    dec CX
sort:
    push CX
    push SI
    
    mov BX, SI
    add BX, 2
    
    findMin:
        mov AX, arr[SI]
        cmp AX, arr[BX]
        JLE nextElem
            mov SI, BX
        nextElem:
            add BX, 2
    LOOP    findMin
    
    pop BX
    cmp BX, SI
    JE sortNext
        mov DX, arr[BX]
        mov AX, arr[SI]
        mov arr[BX], AX
        mov arr[SI], DX
    sortNext:
        mov SI, BX
        add SI, 2
        pop CX
LOOP sort

; Ищем максимальную последовательность повторяющихся элементов
    mov CX, N
    mov BX, 0
    mov tempMax, 1
findMaxSequence:
    mov AX, arr[BX+2]
    cmp AX, arr[BX]
    JNE findMaxSequence_next        ; arr[BX+2] != arr[BX]
        inc tempMax
        mov AX, tempMax
        cmp AX, max
        JL findMaxSequence_next
            mov max, AX
            jmp mark
    findMaxSequence_next:
        mov tempMax, 1
    mark:
        add BX, 2
LOOP    findMaxSequence
    
    lea dx, MsgAnswer
    outstr
    outint max
;================ Code above ================
    pop ax
    pop ds
Exit:
    finish
ENDS

END Start