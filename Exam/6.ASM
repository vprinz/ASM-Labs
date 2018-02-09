; Дан массив, посчитать количество элементов, кратных К между максимумом и минимумом.
%TITLE ""
INCLUDE IO.ASM

MODEL   small

ST1 SEGMENT                     ; Stack segment desc ;
    DB 128 DUP(?)
ST1 ENDS

DATA SEGMENT
	arr             dw  100 DUP(?)
    N               dw  ?
    min             dw  ?
    indexMin        dw  ?
    indexMax        dw  ?
    max             dw  ?
    amount          dw  0
    num             dw  ?
    inputArrSize    db  'Enter array size: $'
    inputK          db  'Enter K: $'
    answer          db  'Answer: $'
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
    lea dx, inputArrSize
    outstr
    inint N
    mov CX, N
    mov BX, 0
inputArr:
    inint arr[BX]
    add BX, 2
LOOP    inputArr

; Ввод числа K
    lea dx, inputK
    outstr
    inint num

; Поиск max и min
    mov CX, N
    mov BX, 0
    mov AX, arr[0]
    mov min, AX
findMin:
    mov AX, arr[BX]
    cmp AX, min
    JGE findMin_next        ; AX > min then go to next (AX < min)
        mov min, AX
        mov indexMin, BX
    findMin_next:
        add BX, 2
LOOP    findMin

    mov CX, N
    mov BX, 0
    mov AX, arr[0]
    mov max, AX
findMax:
    mov AX, arr[BX]
    cmp AX, max
    JLE findMax_next        ; AX < max then go to next (AX > max)
        mov max, AX
        mov indexMax, BX
    findMax_next:
        add BX, 2
LOOP    findMax

; Подсчет элементов
    mov CX, N
    mov BX, 0
findElem:
    cmp BX, indexMin
    JLE next                ; BX < indexMin then go to next (BX > indexMin)
        cmp BX, indexMax
        JGE next            ; BX > indexMax then go to next (BX < indexMax)
            mov AX, arr[BX]
            mov DX, 0
            div num
            cmp DX, 0
            JNE next        ; AH != 0 then go to next (AH = 0)
                inc amount
    next:
        add BX, 2
LOOP    findElem
    
    lea dx, answer
    outstr
    outint amount
;========== End of your code block ======================
    POP     ax
    POP     ds
Exit:
    finish
ENDS

END Start