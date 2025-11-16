.model small
.stack 100h

.data
    message1    db 'Enter a number: $'
    results1    db 'The number $'
    resultsIn   db ' is in the range.$'
    resultsOut  db ' is not in the range.$'

.code
start:
    ; Initialize the data segment
    mov ax, @data
    mov ds, ax

    ; Prompt user
    lea dx, message1
    call printstring

    ; Input character (Result in AL)
    mov ah, 01h
    int 21h
    
    ; Logic: Check if character is between '2' (32h) and '6' (36h)
    cmp al, 32h
    jb not_in_range
    cmp al, 36h
    ja not_in_range

    ; In Range path
    push ax
    call newline
    pop ax

    mov dl, al
    call printcharacter
    lea dx, resultsIn
    call printstring
    jmp exit

not_in_range:
    ; Not In Range path
    push ax
    call newline
    pop ax

    mov dl, al
    call printcharacter
    
    lea dx, resultsOut
    call printstring

exit:
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