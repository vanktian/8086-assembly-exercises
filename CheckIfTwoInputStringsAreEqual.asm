.model small
.stack 100h

.data
    mess1   db 'Enter first string: $'
    mess2   db 0ah, 0dh, 'Enter second string: $'
    mess3   db 0ah, 0dh, 'The two strings are not equal.$'
    mess4   db 0ah, 0dh, 'The two strings are equal.$'
    str1    db 100 dup ('$')
    str2    db 100 dup ('$')

.code
start:
    ; Initialize Data Segment
    mov ax, @data
    mov ds, ax

    ; Input first string
    lea dx, mess1
    call printString
    lea si, str1

loop1:
    call inputCharacter
    cmp al, 0dh          ; Check for Carriage Return (Enter)
    je proceed
    mov [si], al         ; Store character
    inc si
    jmp loop1

proceed:
    call newline
    lea dx, mess2
    call printString
    lea si, str2

loop2:
    call inputCharacter
    cmp al, 0dh          ; Check for Carriage Return (Enter)
    je proceed2
    mov [si], al         ; Store character
    inc si
    jmp loop2

proceed2:
    call newline

compare:
    lea si, str1
    lea di, str2

loop3:
    mov al, [si]
    mov bl, [di]
    cmp al, bl           ; Compare characters
    jne not_equal
    
    cmp al, '$'          ; If both are '$', we reached the end and they match
    je equal
    
    inc si
    inc di
    jmp loop3

not_equal:
    lea dx, mess3
    call printString
    call endProgram

equal:
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

end start