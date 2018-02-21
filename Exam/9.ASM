; Проверить симметричность квадратной матрицы.

%TITLE ""
INCLUDE IO.ASM

MODEL   small

ST1 SEGMENT
    DB 128 DUP(?)
ST1 ENDS

DATA SEGMENT
    N dw ?
    matrix dw 20 dup (20 dup (?))
    i dw ? ; хранит текущую строку
    j dw ? ; хранит текущий столбец
    two db 2
    MsgN db 'Input matrix size: $'
    MsgNeg db 'Matrix is not simmetric $'
    MsgPos db 'Matrix is symmetric $'
DATA ENDS

CODE SEGMENT
ASSUME SS:ST1,DS:DATA,CS:CODE

search proc  ; процедура ищет противоположный элемент в матрице
    push bx
    push si

    mov ax, j
    mul N
    mul two
    mov bx, ax

    mov ax, i
    mul two
    mov si, ax

    mov ax, matrix[bx][si]
    pop si
    pop bx
    ret
search endp


Start:
    push    ds
    push    ax
    mov ax, data    
    mov ds, ax
;========== Put your code below ==============================
; проверить симметричность квадратной матрицы
    lea dx, MsgN
    outstr
    inint N
;============Ввод матрицы=================
    mov cx, N
    mov bx, 0
    inp_row:
        push cx
        mov cx, N
        mov si, 0
        inp_column:
            inint matrix[bx][si]
            add si, 2
        loop inp_column
        add bx, N
        add bx, N
        pop cx
    loop inp_row
;============Ввод матрицы=================

;============Проверка=================
; я решил проверять ниже главной диагонали.
; т.е. беру элемент ниже, а с помощью процедуры ищу
; элемент выше главной
    mov cx, 1 ; проходим начиная с 1 строки, а не с 0
    mov bx, N
    add bx, N
    mov i, 1
    check_row:
        mov ax, cx
        push cx
        mov cx, ax
        mov si, 0
        mov j, 0
        check_column:
            call search     ; результат лежит в ax
            cmp ax, matrix[bx][si]
            jne neg_result

            add si, 2
            inc j
        loop check_column

        add bx, N
        add bx, N
        inc i
        pop cx
        inc cx
    cmp cx, N
    jl check_row

    lea dx, MsgPos
    outstr
    jmp end_prog

    neg_result:
    lea dx, MsgNeg
    outstr

    end_prog:

;========== End of your code block ===========================
    pop ax
    pop ds
Exit:
    finish
ENDS

END Start