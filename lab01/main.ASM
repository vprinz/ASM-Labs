%TITLE ""
INCLUDE IO.ASM

MODEL   small

ST1 SEGMENT                     ; Stack segment desc ;
    DB 128 DUP(?)
ST1 ENDS

DATA SEGMENT
	N dw ?
	two db 2
	sum dw ?
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
	MOV	BX, 0  ; Счетчик суммы
	ININT N
	MOV	AX, N
	DIV two
	CMP AH, 0	; Проверка на чётность
	JE A1		; Если четный, то переходим на метку A1
	
	MOV	sum,	1
	JMP A2
A1:
	MOV sum,	2

A2:
	MOV AX, N
	CMP sum, AX
	JG A3	     ; Если больше, то переходим на метку A3
	
	ADD BX,	sum
	ADD sum,	2
	JMP A2
	
A3:
	OUTINT	BX
;========== End of your code block ======================
    POP     ax
    POP     ds
Exit:
    finish
ENDS

END Start