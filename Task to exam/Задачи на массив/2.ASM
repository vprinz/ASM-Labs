%TITLE "‚ и Є®¬¬Ґ в аЁ© Їа®Ја ¬¬л" 
INCLUDE IO.ASM 

MODEL small 

ST1 SEGMENT ;ЋЇЁб «Ё бҐЈ¬Ґ в бвҐЄ ; 
db 32 dup(?) 
ST1 ENDS 

DATA SEGMENT 
a Dw 128 DUP(?) 
t dw 0 
n dw ? 
n2 dw ? 
s dw ? 
DATA ENDS 


CODE SEGMENT ;®вЄал«Ё бҐЈ¬Ґ в Є®¤ ; 
ASSUME SS:ST1,DS:DATA,CS:CODE 



Start: 
push ds 
push ax 


inint n 
mov bx,0 
mov cx,n 

l: 

inint a[bx] 
add bx,2 
loop l 



    mov cx, n
k:
    mov si, cx 
    dec si 
    mov bx, si 
    add bx, si
    
    mov ax, a[bx] 
    mov bp, bx
    mov bx, 0 
    mov si, cx 
h:
    cmp ax, a[bx] 
    jg f 
    mov ax,a[bx] 
    mov bp,bx 
    f:
        add bx,2 
loop h
    mov cx,si 
    mov di,a[bp] 
    dec si 
    mov bx,si 
    add bx,si 
    mov dx,a[bx] 
    mov a[bp],dx 
    mov a[bx],di 
loop k 






mov cx,n 
mov bx,0 
l1: 

outint a[bx],4 
add bx,2 
loop l1 


pop ax 
pop ds 
Exit: 
finish 
ENDS 

END Start