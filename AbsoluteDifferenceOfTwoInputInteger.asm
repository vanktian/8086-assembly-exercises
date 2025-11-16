.model small
.stack 100h

.data
    mess1 db 'Enter First number: $'
    mess2 db 0ah,0dh,'Enter Second number: $'
    mess3 db 0ah,0dh,'The difference is $'

.code
start:
    ; Initialize data segment
    mov ax, @data
    mov ds, ax

    ; Clear screen
    mov ax, 03
    int 10h

    ; Get first number
    mov dx, offset mess1
    call PrintString
    call Input
    mov bl, al

    ; Get second number
    mov dx, offset mess2
    call PrintString
    call Input

    ; Logic to handle which number is larger
    cmp al, bl
    jg proceed

    ; If BL >= AL
    sub bl, al
    aas
    add bl, 30h
    mov dx, offset mess3
    call PrintString
    mov dl, bl
    mov ah, 2
    int 21h

    mov dl, '.'
    mov ah, 2
    int 21h

    jmp exit

proceed:
    sub al, bl
    aas
    add al, 30h
    push ax
    mov dx, offset mess3
    call PrintString
    pop ax
    mov dl, al
    mov ah, 2
    int 21h

    mov dl, '.'
    mov ah, 2
    int 21h

exit:
    mov ax, 4c00h ; Standard termination for .model small
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

end start