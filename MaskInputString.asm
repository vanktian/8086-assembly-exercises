.model small
.stack 100h

.data
    mess1 db 'Enter string: $'
    str1  db 100 dup ('$')

.code
start:
    ; Initialize the Data Segment
    mov ax, @data
    mov ds, ax

    ; Prompt user
    lea dx, mess1
    call printString
    lea si, str1

loop1:
    ; Using function 07h (Direct Input, No Echo) 
    ; so the actual character isn't visible
    mov ah, 07h
    int 21h

    cmp al, 0dh          ; Check for Enter key (Carriage Return)
    je proceed

    mov [si], al         ; Store character in buffer
    inc si
    
    call printAsterisk   ; Print '*' to mask input
    jmp loop1

proceed:
    call newline
    
    ; Display the actual stored string
    lea dx, str1
    call printString
    
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
    ; This prints a '*' to the screen
    mov dl, 42           ; ASCII for '*'
    call printCharacter
    ret

end start