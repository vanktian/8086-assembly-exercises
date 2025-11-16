.model small
.stack 100h

.data
    ; Initialize data segment pointers
    mess1   db 'Enter string: $'
    
    ; Buffered input structure:
    ; Byte 0: Max characters to read (78 + CR + Terminator)
    ; Byte 1: Actual number of characters read (filled by DOS)
    ; Byte 2+: The actual string data
    buffer  db 80, 0, 80 dup('$') 

.code
start:
    ; Initialize the Data Segment (DS)
    mov ax, @data
    mov ds, ax

    ; Print the prompt
    lea dx, mess1
    call printString

    ; Read the string into the buffer
    lea dx, buffer
    call inputString
    
    ; Move to a new line
    call newline

    ; Print the string starting from the 3rd byte (buffer + 2)
    ; to skip the length metadata bytes
    lea dx, buffer+2
    call printString

    ; Exit to DOS
    call endProgram

; --- Functions ---

inputCharacter:
    mov ah, 01h
    int 21h
    ret

inputString:
    mov ah, 0Ah
    int 21h
    ret

printCharacter:
    mov ah, 02h
    int 21h
    ret

printString:
    mov ah, 09h
    int 21h
    ret

endProgram:
    mov ah, 4Ch
    int 21h

newline:
    mov dl, 10
    call printCharacter
    mov dl, 13
    call printCharacter
    ret

printAsterisk:
    mov dl, 8
    call printCharacter
    mov dl, 42
    call printCharacter
    ret

end start