; Процедура возведения элементов массива в квадрат.
%TITLE ""
INCLUDE IO.ASM

MODEL   small

ST1 SEGMENT                     ; Stack segment desc ;
    DB 128 DUP(?)
ST1 ENDS

DATA SEGMENT
	arr dw 128 DUP(?)
	arrSize dw ?
DATA ENDS


CODE    SEGMENT                 ; Code segment opened ;
ASSUME  SS:ST1,DS:DATA,CS:CODE  ; Registry segments assignment ;
EXTRN   fib:near

SquareNum proc
	MOV AX, [BX]
	MUL AX
	MOV [BX], AX
	ret
SquareNum endp


Start:
    PUSH    ds
    PUSH    ax
    MOV     ax, data    
    MOV     ds, ax
;========== Put your code below =========================
	ININT arrSize
	MOV CX, arrSize
	MOV BX, 0
A: 
	ININT arr[BX]
	ADD BX, 2
	MOV AX, arr[BX]
	LOOP	A	
	
	MOV CX, arrSize
	MOV BX, 0
	
A1:	
	MOV AX, arr[BX]
	CALL SquareNum
	MOV arr[BX], AX
	OUTINT arr[BX], 4
	ADD BX, 2
	LOOP	A1
;========== End of your code block ======================
    POP     ax
    POP     ds
Exit:
    finish
ENDS

END Start