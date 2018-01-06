; Дана матрица. Обнулить все элементы, лежащие ниже побочной диагонали одним регистром.
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
	inint N
	mov ax, N
	mul N
	mov cx, ax
	mov bx, 0
a1:
	inint arr[bx]
	add bx, 2
	loop a1

	mov dx, N
	add dx, N
	mov cx, N
	mov bx, 0
	mov si, dx
	add si, 2
	mov ax, 0
a2:
	sub si, 2
	add bx, si
	mov ax, cx
	mov cx, N

a3:
	cmp bx, dx
	jge a4
		mov arr[bx], 0
		add bx, 2
		loop a3
a4:
	mov cx,	ax
	mov bx,	dx
	add dx,	N
	add dx,	N
	loop a2
	mov cx,	N
	mov bx,	0
	
a5:
	push cx
    mov cx,	N
    mov si,	0
	
a6:
	outint arr[bx][si], 2
    add si,	2
    loop a6
    newline
    pop cx
    add bx,	N
    add bx,	N
    loop a5 
;========== End of your code block ======================
    POP     ax
    POP     ds
Exit:
    finish
ENDS

END Start