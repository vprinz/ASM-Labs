; Дан массив. Посчитать кол-во положительных и отрицательных элементов.
%TITLE ""
INCLUDE IO.ASM

MODEL   small

ST1 SEGMENT                     ; Stack segment desc ;
    DB 128 DUP(?)
ST1 ENDS

DATA SEGMENT
	MsgN		DB	'Enter N: $'
	MsgElem		DB	'Enter elem of arr: $'
	MsgAnswer	DB	'Answer: $'
	
	arr			DW	100 dup(?)
	N			DW	?
	countPos	DW	0
	countNeg	DW	0
	countNil	Dw	0
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
	LEA DX, MsgN
	OUTSTR
	ININT N
	
	MOV CX, N
	MOV BX, 0
A:
	LEA DX, MsgElem
	OUTSTR
	ININT arr[BX]
	ADD BX, 2
	LOOP A

	MOV CX, N
	MOV BX, 0
A1:
	MOV AX, arr[BX]
	CMP AX, 0
	JL A2
		INC countPos
A2:
	ADD BX,	2
	LOOP	A1

	MOV CX, N
	MOV BX, 0
A3:
	MOV AX, arr[BX]
	CMP AX, 0
	JG A4
		INC countNeg
A4:
	ADD BX,	2
	LOOP	A3
	
	LEA DX, MsgAnswer
	OUTSTR
	OUTINT countPos
	
	LEA DX, MsgAnswer
	OUTSTR
	OUTINT countNeg
;========== End of your code block ======================
    POP     ax
    POP     ds
Exit:
    finish
ENDS

END Start