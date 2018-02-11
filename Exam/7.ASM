; Дан массив, найти сумму чисел максимальной пары соседних элементов и вывести эти элементы.

%TITLE ""
INCLUDE IO.ASM

MODEL   small

ST1 SEGMENT                     ; Stack segment desc ;
    DB 128 DUP(?)
ST1 ENDS

DATA SEGMENT
	arr         dw 100 dup(?)
    N           dw  ?
    max         dw  ?
    firstElem   dw  ?
    secondElem  dw  ?
    msgAnswer   db  'Answer: $'
    enterN      db  'Enter array size: $'
DATA ENDS


CODE    SEGMENT                 ; Code segment opened ;
ASSUME  SS:ST1,DS:DATA,CS:CODE  ; Registry segments assignment ;
EXTRN   fib:near


Start:
    PUSH    ds
    PUSH    ax
    MOV     ax, data    
    MOV     ds, ax
;========== Put your code below =========================
; Ввод массива
    lea dx, enterN
    outstr
    inint N
    mov CX, N
    mov BX, 0
inputArr:
    inint arr[BX]
    add BX, 2
LOOP    inputArr

; Поиск суммы максимальной пары
    mov CX, N
    mov BX, 0
    mov max, 0
findMax:
    mov AX, arr[BX+2]
    add AX, arr[BX]     ; AX := AX + arr[BX]
    cmp AX, max
    JLE next            ; AX < max go to next (AX > max)
        mov max, AX
        mov AX, arr[BX]
        mov firstElem, AX
        mov AX, arr[BX+2]
        mov secondElem, AX
    next:
        add BX, 2
LOOP      findMax

    lea dx, msgAnswer
    outstr
    outint firstElem
    outint secondElem, 2
;========== End of your code block ======================
    POP     ax
    POP     ds
Exit:
    finish
ENDS

END Start