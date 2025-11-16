.model small
.stack 100h

.data
    nextline db 0ah,0dh,'$'
    mess1    db 'Enter First number: $'
    mess2    db 0ah,0dh,'Enter Second number: $'
    mess3    db 0ah,0dh,'[1] Addition',0ah,0dh,'[2] Subtraction'
             db 0ah,0dh,'[3] Input New Set of Number',0ah,0dh,'[4] Exit'
             db 0ah,0dh,'Select: $'
    mess4    db 0ah,0dh,'Error, Please Try Again!$'

    answer1  db 0ah,0dh,'The Sum is $'
    answer2  db 0ah,0dh,'The Difference is $'

.code
start:
    ; Initialize the Data Segment
    mov ax, @data
    mov ds, ax

    ; Clear Screen
    mov ax, 03
    int 10h

get_numbers:
    mov dx, offset mess1
    call PrintString
    call Input
    mov ch, al          ; Store first number in CH

    mov dx, offset mess2
    call PrintString
    call Input
    mov cl, al          ; Store second number in CL

Menu:
    mov dx, offset nextline
    call PrintString

    mov dx, offset mess3
    call PrintString
    call Input

    cmp al, 31h         ; '1'
    je Addition
    cmp al, 32h         ; '2'
    je Subtraction
    cmp al, 33h         ; '3'
    je get_numbers
    cmp al, 34h         ; '4'
    je Exit

    ; Error handling
    mov dx, offset mess4
    call PrintString
    jmp get_numbers

Addition:
    mov al, ch
    mov bl, cl

    mov ah, 0
    add al, bl
    aaa                 ; ASCII Adjust for Addition

    push ax
    mov dx, offset answer1
    call PrintString
    pop ax

    cmp ah, 01h         ; Check for carry (two digits)
    jne onedigit

    mov dh, al
    add ah, 30h
    mov dl, ah
    mov ah, 2
    int 21h

    mov al, dh
    add al, 30h
    mov dl, al
    mov ah, 2
    int 21h

    jmp Menu

onedigit:
    add al, 30h
    mov dl, al
    mov ah, 2
    int 21h

    jmp Menu

Subtraction:
    mov dx, offset answer2
    call PrintString

    mov al, ch
    mov bl, cl

    cmp bl, al          ; Check if second number is larger
    jg proceed

    sub al, bl
    aas                 ; ASCII Adjust for Subtraction
    add al, 30h
    mov dl, al
    mov ah, 2
    int 21h

    jmp Menu

proceed:
    mov ah, 0
    sub bl, al
    mov al, bl
    aas
    add al, 30h
    push ax

    call negative       ; Print '-' sign
    pop ax
    mov dl, al
    mov ah, 2
    int 21h

    jmp Menu

Exit:
    mov ax, 4c00h       ; Standard DOS termination
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

negative:
    mov dl, 2dh         ; ASCII for '-'
    mov ah, 2
    int 21h
    ret

end start