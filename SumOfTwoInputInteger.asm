.model small
.stack 100h

.data
    mess1 db 'Enter First number: $'
    mess2 db 0ah, 0dh, 'Enter Second number: $'
    mess3 db 0ah, 0dh, 'The Sum is $'

.code
start:
    ; Initialize the Data Segment
    mov ax, @data
    mov ds, ax

    ; Clear Screen
    mov ax, 03
    int 10h

    ; Input first number (2 digits)
    mov dx, offset mess1
    call PrintString
    
    call Input
    sub al, 30h
    mov bh, al          ; First number, 10s digit

    call Input
    sub al, 30h
    mov bl, al          ; First number, 1s digit

    ; Input second number (2 digits)
    mov dx, offset mess2
    call PrintString
    
    call Input
    sub al, 30h
    mov ch, al          ; Second number, 10s digit

    call Input
    sub al, 30h
    mov cl, al          ; Second number, 1s digit

    ; --- Addition Logic ---

    ; Add the 1s digits
    add bl, cl
    mov al, bl
    mov ah, 00h
    aaa                 ; Adjust for carry in 1s place
    

    mov cl, al          ; Final 1s digit stored in CL
    mov bl, ah          ; Carry stored in BL

    ; Add the 10s digits + carry
    add bl, bh
    add bl, ch
    mov al, bl
    mov ah, 00h
    aaa                 ; Adjust for carry in 10s place

    mov bx, ax          ; Resulting 100s (BH) and 10s (BL) stored

    ; --- Display Results ---

    mov dx, offset mess3
    call PrintString

    ; Print 100s digit
    mov dl, bh
    add dl, 30h
    mov ah, 2
    int 21h

    ; Print 10s digit
    mov dl, bl
    add dl, 30h
    mov ah, 2
    int 21h

    ; Print 1s digit
    mov dl, cl
    add dl, 30h
    mov ah, 2
    int 21h

    ; Print trailing dot
    mov dl, '.'
    mov ah, 2
    int 21h

    ; Standard Exit
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

end start