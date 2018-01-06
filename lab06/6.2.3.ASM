; Дана матрица. Обнулить все элементы, лежащие выше побочной диагонали одним регистром.
%TITLE ""
INCLUDE IO.ASM

MODEL   small

ST1 SEGMENT                     ; Stack segment desc ;
    DB 128 DUP(?)
ST1 ENDS

DATA SEGMENT
	arr DW 256 DUP(?)
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

;========== ВВОД МАТРИЦЫ ==========
	ININT N
	MOV AX, N
	MUL N
	MOV CX, AX
	MOV BX, 0
A1:
	ININT arr[BX]
	ADD BX, 2
	LOOP A1
	
	MOV DX, N
	ADD DX, N
	MOV CX, N
	MOV BX, 0
	MOV SI, DX
	MOV AX, 0

A2:
	SUB SI, 2
	MOV AX, CX
	MOV CX, N
	
A3:
	CMP BX, SI
	JGE A4
		MOV arr[BX], 0
		ADD BX, 2
		LOOP A3
A4:
	MOV CX, AX
	MOV BX, DX
	ADD SI, N
	ADD SI, N
	ADD DX, N
	ADD DX, N
	LOOP A2

	MOV CX, N
	MOV BX, 0
	
A5:
	PUSH CX
	MOV CX, N
	MOV SI, 0

A6:
	OUTINT arr[BX][SI], 2
	ADD SI, 2
	LOOP A6
	NEWLINE
	POP CX
	ADD BX, N
	ADD BX, N
	LOOP A5    
;========== End of your code block ======================
    POP     ax
    POP     ds
Exit:
    finish
ENDS

END Start