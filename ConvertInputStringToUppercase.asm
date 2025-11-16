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
    call inputCharacter
    mov [si], al         ; Store the character
    inc si
    cmp al, 0dh          ; Check for Enter key (Carriage Return)
    jne loop1            ; Keep looping if not Enter

proceed:
    call newline
    lea si, str1

loop2:
    mov al, [si]
    
    ; Check for string termination (End of input or string)
    cmp al, 0dh          
    je proceed2
    cmp al, '$'
    je proceed2

    ; Check if character is lowercase ('a' through 'z')
    cmp al, 61h          ; ASCII 'a'
    jb not_lowercase
    cmp al, 7ah          ; ASCII 'z'
    ja not_lowercase

    ; Convert to uppercase
    sub al, 20h
    mov [si], al

not_lowercase:
    inc si
    jmp loop2

proceed2:
    call newline
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

end start