.model small
.stack 100h

.data
    message1    db 'Enter a letter: $'
    results1    db 'The letter $'
    resultsIn   db ' is in lowercase.$'
    resultsOut  db ' is not lowercase.$'

.code
start:
    ; Initialize the data segment (pointing DS to .data)
    mov ax, @data
    mov ds, ax

    ; Prompt the user
    lea dx, message1
    call printstring

    ; Input character (Result stored in AL)
    mov ah, 01h
    int 21h
    
    ; Check if character is between 'a' (61h) and 'z' (7Ah)
    cmp al, 61h
    jb not_in_range
    cmp al, 7Ah
    ja not_in_range

    ; Logic for: Lowercase
    push ax
    call newline
    pop ax

    mov dl, al
    call printcharacter
    lea dx, resultsIn
    call printstring
    jmp exit

not_in_range:
    ; Logic for: Not Lowercase
    push ax
    call newline
    pop ax

    mov dl, al
    call printcharacter
    
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