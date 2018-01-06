; Вводим N. Если четный, то сумма четных до N, иначе сумма нечетных до N
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

	firstArr	DW	100 DUP(?)
	secondArr	DW	100 DUP(?)
	two			DW	2
	N			DW 	?
	t			DW	?
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
	LEA 	DX, MsgN
	OUTSTR
	ININT N
	MOV CX, N
	MOV BX, 0
A1:
	LEA	DX,	MsgElem 
	OUTSTR
	ININT firstArr[BX]
	ADD BX, 2
	LOOP	A1

	MOV CX, N
	MOV BX, -2
	LEA	DX, MsgAnswer
	OUTSTR
A2:
	ADD BX, 2
	MOV AX, firstArr[BX]	; Присвоили регистру AX значение элемента массива firstArr
	MOV DX, 0
	DIV two					; Делим на 2
	
	MOV AX, 0
	MOV t,  0
	
	CMP DX, 0 				; Проверка на четность
	JE A3					; Если равно, то переходим на метку A3
	ADD AX, 1
	ADD t,  1
A3: 
	ADD t,  2

	ADD AX, t
	MOV DX, t
	CMP DX, firstArr[BX]
	JNE A3					; Если не равно, то переходим на метку A3

	MOV secondArr[BX], AX
	OUTINT secondArr[BX], 4
	LOOP	A2
;========== End of your code block ======================
    POP     ax
    POP     ds
Exit:
    finish
ENDS

END Start