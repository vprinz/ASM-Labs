; Дан массив. Найти номер первого локального минимума.
%TITLE ""
INCLUDE IO.ASM

LOCALS  __

MODEL   small

ST1 SEGMENT
    DB 128 DUP(?)
ST1 ENDS

DATA SEGMENT
    arr dw  100 DUP(?)
    N   dw  ?
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
    sub CX, 2   ; пройти N-2 элемента (т.е. не включая 0-вой и последний элем)
    mov BX, 2   ; начинаем проверку с 1 элемента
searchLocalMin:
    mov AX, arr[BX-2]
    cmp AX, arr[BX]
    JL searchLocalMin_next
        mov AX, arr[BX+2]
        cmp arr[BX], AX
        JG searchLocalMin_next
            JMP result      ; если зашёл сюда - мы нашли наш локальный минимум
    searchLocalMin_next:
        add BX, 2
LOOP    searchLocalMin
    
    JMP endProg     ; если зашли сюда - значит, локального минимума нет
    
result:
    outint BX

endProg:
;================ Code above ================
    pop ax
    pop ds
Exit:
    finish
ENDS

END Start