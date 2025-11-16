.model small
.stack 100h

.data
    message1    db 'Enter a letter: $'
    resultsOut  db 'Character entered is not in the lowercase range.$'

.code
start:
    ; Initialize the data segment
    mov ax, @data
    mov ds, ax

    ; Prompt the user
    lea dx, message1
    call printstring

    ; Input character (Result in AL)
    mov ah, 01h
    int 21h
    
    ; Check if character is between 'a' (61h) and 'z' (7Ah)
    cmp al, 61h
    jb not_in_range
    cmp al, 7Ah
    ja not_in_range

    ; Logic: Convert to Uppercase
    push ax
    call newline
    pop ax

    sub al, 20h          ; Convert lowercase to uppercase
    mov dl, al
    call printcharacter
    jmp exit             ; Jump to exit to avoid falling into not_in_range

not_in_range:
    ; Logic: Error message
    push ax
    call newline
    pop ax
    
    lea dx, resultsOut
    call printstring

exit:
    ; Standard DOS termination
    mov ax, 4C00h
    int 21h

; --- Functions ---

printcharacter:
    mov ah, 02h
    int 21h
    ret

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