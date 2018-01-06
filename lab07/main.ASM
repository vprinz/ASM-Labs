; Дан массив. Найти индекс максимального элемента.
%TITLE ""
INCLUDE IO.ASM

MODEL   small

ST1 SEGMENT                     ; Stack segment desc ;
    DB 128 DUP(?)
ST1 ENDS

DATA SEGMENT
	arr DW 128 DUP(?)
	Msg	DB	'Input massive size: $'
	arrSize DW ?
	max DW ?
	number DW ?
	TWO DW 2
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
	LEA	DX, Msg ; Вывод сообщения "Введите размер массива"
	OUTSTR
	ININT arrSize ; Ввод размер массива

	MOV	CX, arrSize	; Заносим в регистр CX размер массива
	MOV	BX, 0

CycleIn:	; Заполняем массив
	ININT arr[BX]
	ADD	BX, 2
	LOOP	CycleIn;
;==============================

	MOV BX, 0
	MOV	AX, arr[BX];
	ADD BX, 2

	MOV max, AX	; Присвоили max первый элемент массива
	MOV AX, 0
	MOV number, AX	; Присвоили number номер индекс элемента
	
;==============================
	MOV	CX, arrSize
	DEC CX
	MOV AX, max

CycleChange:
	MOV AX, max
	cmp arr[BX], AX
	JL next
		MOV AX, arr[BX]
		MOV max, AX
		MOV number, BX
	next:
		ADD BX, 2
	
	LOOP CycleChange
	

	MOV AX, number
	MOV DX, 0
	DIV TWO

	OUTINT	AX
;========== End of your code block ======================
    POP     ax
    POP     ds
Exit:
    finish
ENDS

END Start