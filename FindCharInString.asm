.model small
.stack 100h

.data
    mess1   db 'Enter string: $'
    mess2   db 0ah, 0dh, 'Enter a character to search in string: $'
    mess3   db 0ah, 0dh, 'Character is found.$'
    mess4   db 0ah, 0dh, 'Character is not found.$'
    str1    db 100 dup ('$')

.code
start:
    ; Initialize the Data Segment
    mov ax, @data
    mov ds, ax

    ; Prompt for the string
    lea dx, mess1
    call printString
    lea si, str1

loop1:
    call inputCharacter  ; Standardizing to your input function
    mov [si], al
    inc si
    cmp al, 0dh          ; Check for Carriage Return (Enter key)
    je proceed
    jmp loop1

proceed:
    call newline
    lea dx, mess2
    call printString
    
    ; Get the character to search for
    call inputCharacter
    mov bl, al           ; Store target character in BL
    lea si, str1

loop2:
    mov al, [si]
    cmp al, bl           ; Compare current char with target
    je found
    
    cmp al, '$'          ; Check for end of string
    je not_found
    
    inc si
    jmp loop2

found:
    lea dx, mess3
    call printString
    call endProgram

not_found:
    lea dx, mess4
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
    mov dl, 8
    call printCharacter
    mov dl, 42
    call printCharacter
    ret

end start