.model small
.stack 100h

.data
    message1 db 'Enter character to display: $'
    message2 db 0ah, 0dh, 'Enter number of times to display character (1-9): $'

.code
start:
    ; Initialize the Data Segment
    mov ax, @data
    mov ds, ax

    ; Get the character to display
    mov dx, offset message1
    call printstring

    mov ah, 01h
    int 21h
    push ax             ; Store character on stack

    ; Get the iteration count
    mov dx, offset message2
    call printstring

    mov ah, 01h
    int 21h
    push ax             ; Store ASCII digit on stack

    call newline

    ; Setup Loop Counter (CX)
    pop ax              ; Get ASCII digit
    xor cx, cx          ; Clear CX
    sub al, '0'         ; Convert ASCII ('1'-'9') to numeric (1-9)
    mov cl, al          ; Move count to CX (CL)

    ; Setup Display Character (DL)
    pop ax              ; Get original character
    mov dl, al

my_loop:
    mov ah, 02h
    int 21h
    loop my_loop        ; Decrements CX and jumps to my_loop if CX > 0

    ; Standard Exit (Prevents falling into functions below)
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