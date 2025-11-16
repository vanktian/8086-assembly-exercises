.model small
.stack 100h

.data
    message1 db 'Enter number of times to display string (0-9): $'
    message2 db 'Hello World $'

.code
start:
    ; Initialize the Data Segment
    mov ax, @data
    mov ds, ax

    ; Prompt for number of iterations
    mov dx, offset message1
    call printstring

    ; Input character (Result in AL)
    mov ah, 01h
    int 21h

    ; Convert ASCII character to numeric value for CX
    ; AL holds the ASCII (e.g., '5' = 35h). Subtracting '0' (30h) gives 5.
    mov ah, 0
    sub al, '0'
    mov cx, ax          ; Move the count into CX for the loop instruction

    call newline

    ; If user enters '0', CX becomes 0. 
    ; Note: The LOOP instruction in x86 will wrap around to 65535 if CX is 0.
    jcxz exit           ; Jump to exit if CX is zero to prevent infinite-like loop

my_loop:
    mov dx, offset message2
    call printstring
    call newline

    loop my_loop        ; Decrements CX and jumps if CX != 0

exit:
    mov ax, 4c00h       ; Standard DOS termination
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