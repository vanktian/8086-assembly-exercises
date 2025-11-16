.model small
.stack 100h

.data
    mess1 db 'Enter First number: $'
    mess2 db 0ah, 0dh, 'Enter Second number: $'
    mess3 db 0ah, 0dh, 'The Difference is $'

.code
start:
    ; Initialize the Data Segment
    mov ax, @data
    mov ds, ax

    ; Clear Screen
    mov ax, 03
    int 10h

    ; Input first number
    mov dx, offset mess1
    call PrintString
    call Input
    mov bl, al          ; BL = First Number

    ; Input second number
    mov dx, offset mess2
    call PrintString
    call Input
    mov bh, al          ; BH = Second Number

    ; Compare BH (2nd) and BL (1st)
    cmp bh, bl
    jg proceed

    ; Path: First Number >= Second Number (Positive Result)
    mov ah, 0
    sub bl, bh          ; Subtract BH from BL
    mov al, bl
    aas                 ; ASCII Adjust for Subtraction
    add al, 30h
    push ax

    mov dx, offset mess3
    call PrintString

    pop ax
    mov dl, al
    mov ah, 2
    int 21h

    call dot
    jmp exit

proceed:
    ; Path: Second Number > First Number (Negative Result)
    mov ah, 0
    sub al, bl          ; AL already contains the 2nd number (BH)
    aas
    add al, 30h
    push ax

    mov dx, offset mess3
    call PrintString

    ; Print '-' sign (ASCII 2dh)
    mov ah, 6
    mov dl, 2dh
    int 21h

    pop ax
    mov dl, al
    mov ah, 2
    int 21h

    call dot

exit:
    ; Standard DOS termination
    mov ax, 4c00h
    int 21h

; --- Functions ---

PrintString:
    mov ah, 9
    int 21h
    ret

Input:
    mov ah, 1
    int 21h
    ret

dot:
    mov dl, '.'
    mov ah, 2
    int 21h
    ret

end start