; Дан массив. Если он упорядочен по убыванию, то обнулить все элементы, кртаные 13.
%TITLE ""
INCLUDE IO.ASM

MODEL   small

ST1 SEGMENT                     ; Stack segment desc ;
    DB 128 DUP(?)
ST1 ENDS

DATA SEGMENT
	MsgN		dw	'Enter N: $'
	MsgElem		dw	'Enter elem of arr: $'
	MsgAnswer	dw	'Answer: $'
	
	arr		 	dw 100 dup(?)
	N 		 	dw ?
	thirteen 	dw 13
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
	DEC CX
	MOV BX, 0
A1:
	MOV AX, arr[BX]
	CMP AX, arr[BX+2]
	JL A2
		JMP L1
A2:
	ADD BX, 2
	LOOP A1
	JMP L2

L1:
	MOV CX, N
	MOV BX, 0
A4:
	MOV AX, arr[BX]
	MOV DX, 0
	DIV thirteen
	CMP DX, 0
	JNE A3
		MOV arr[BX], 0
A3:
	ADD BX, 2
	LOOP A4

L2:
	MOV CX, N
	MOV BX, 0
	
	LEA DX, MsgAnswer
	OUTSTR
A5:
	OUTINT arr[BX], 3
	ADD BX, 2
	LOOP A5
;========== End of your code block ======================
    POP     ax
    POP     ds
Exit:
    finish
ENDS

END Start