; В квадратной матрице найти элемент выше главной диагонали из отрезка [a; b], причем предполагается, что он точно есть.
%TITLE ""
INCLUDE IO.ASM

MODEL   small

ST1 SEGMENT                     ; Stack segment desc ;
    DB 128 DUP(?)
ST1 ENDS

DATA SEGMENT
	matrix          dw  20 DUP(20 DUP(?))
    N               dw  ?
    i               dw  ?
    elem            dw  ?
    firstVal        dw  ?
    lastVal         dw  ?
    inputFirstVal   db  'Enter first value from interval: $'
    inputLastVal    db  'Enter last value from interval: $'
    inputN          db  'Enter matrix size: $'
    msgAnswer       db  'Answer: $'
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
; Ввод матрицы
    lea dx, inputN
    outstr
    inint N
    mov CX, N
    mov BX, 0
inputRow:
    push CX
    mov CX, N
    mov SI, 0
    inputCol:
        inint matrix[BX][SI]
        add SI, 2
    LOOP    inputCol
    add BX, N
    add BX, N
    pop CX
LOOP    inputRow

; Ввод промежутка

    lea dx, inputFirstVal
    outstr
    inint firstVal
    
    lea dx, inputLastVal
    outstr
    inint lastVal

; Поиск элемента
    mov CX, N
    mov i, CX
    mov BX, 0    
startProg:
    push CX
    mov CX, i
    mov SI, N
    add SI, N
    sub SI, 2
    findElem:
        mov AX, matrix[BX][SI]
        cmp AX, firstVal
        JLE  next                ; AX < 5 then go to next (AX > 5)
            cmp AX, lastVal
            JGE  next            ; AX > 7 then go to next (AX < 7)
                mov elem, AX
        next:
            sub SI, 2
    LOOP    findElem
    dec i
    add BX, N
    add BX, N
    pop CX
LOOP    startProg

    lea dx, msgAnswer
    outstr
    outint elem
;========== End of your code block ======================
    POP     ax
    POP     ds
Exit:
    finish
ENDS

END Start