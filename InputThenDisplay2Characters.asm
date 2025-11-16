.model small
.stack 100h

.data
    message1 db 'Enter first character: $'
    message2 db 0ah, 0dh, 'Enter second character: $'
    results  db ' and $'

.code
start:
    ; Initialize the Data Segment
    mov ax, @data
    mov ds, ax

    ; Get first character
    mov dx, offset message1
    call printstring
    mov ah, 01h
    int 21h
    push ax             ; First char pushed to stack

    ; Get second character
    mov dx, offset message2
    call printstring
    mov ah, 01h
    int 21h
    push ax             ; Second char pushed to stack

    call newline

    ; Pop characters (LIFO order)
    pop ax              ; Pops second character first
    mov bl, al          ; Move second char to BL

    pop ax              ; Pops first character
    mov dl, al          ; Move first char to DL for printing

    ; Print first character entered
    mov ah, 02h
    int 21h

    ; Print " and "
    mov dx, offset results
    call printstring

    ; Print second character entered
    mov dl, bl
    mov ah, 02h
    int 21h

    ; Exit program
    mov ax, 4c00h
    int 21h

; --- Functions ---

printstring:
    mov ah, 09h
    int 21h
    ret

newline:
    mov dl, 10
    mov ah, 02h
    int 21h
    mov dl, 13
    mov ah, 02h
    int 21h
    ret

end start