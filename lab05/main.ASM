; Дана матрица. Подсчитать сумму элементов тех столбцов, в которых пятый элемент равен 0.
%TITLE ""

; 1  2  3  4  5
; 6  7  8  9  10
; 11 12 13 14 15
; 16 17 18 19 20
; 0  22 23 24 25

INCLUDE IO.ASM

MODEL   small

ST1 SEGMENT                     ; Stack segment desc ;
    DB 128 DUP(?)
ST1 ENDS

DATA SEGMENT
	arr DW 256 DUP(?)
	ten DW 8
	N DW ?
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

;========== Ввод матрицы =========================
	ININT N
	MOV AX, N
	MUL ten
	MOV SI, 0
	MOV CX, N

A1:
	MOV BX, 0
	MOV DI, CX
	MOV CX, N

A2:
	ININT arr[SI][BX]
	ADD BX, 2
	LOOP	A2
	
	MOV CX, DI
	ADD SI, N
	ADD SI, N
	LOOP	A1

;========== Вычисление суммы =========================

	MOV BX, 0
	MOV DI, 0
	MOV CX, N

A3:
	MOV SI, AX
	CMP arr[SI][BX], 0
	JNE A5
		MOV DX, CX
		MOV SI, 0
		MOV CX, N

A4:
	ADD DI, arr[SI][BX]
	ADD SI, N
	ADD SI, N
	LOOP	A4

	MOV CX, DX

A5:
	ADD BX, 2
	LOOP	A3

;========== Вывод ответа =========================

	OUTINT DI
;========== End of your code block ======================
    POP     ax
    POP     ds
Exit:
    finish
ENDS

END Start