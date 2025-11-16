.model small
.stack 100h

.data
    message1 db 'Enter first character: $'
    message2 db 'Enter second character: $'
    message3 db 'Enter third character: $'
    results1 db 'The characters are $'
    results2 db ' , $'
    results3 db ' and $'
    results4 db '.$'

.code
start:
    ; Initialize the Data Segment
    mov ax, @data
    mov ds, ax

    ; --- Input Phase ---

    ; Get first character
    mov dx, offset message1
    call printstring
    mov ah, 01h
    int 21h
    push ax             ; Stack: [Char1]

    call newline

    ; Get second character
    mov dx, offset message2
    call printstring
    mov ah, 01h
    int 21h
    push ax             ; Stack: [Char1, Char2]

    call newline

    ; Get third character
    mov dx, offset message3
    call printstring
    mov ah, 01h
    int 21h
    push ax             ; Stack: [Char1, Char2, Char3]

    call newline

    ; --- Output Phase ---

    mov dx, offset results1
    call printstring

    ; Pop in reverse order to retrieve original inputs
    pop ax              ; AL = 3rd character
    mov bl, al

    pop ax              ; AL = 2nd character
    mov cl, al

    pop ax              ; AL = 1st character
    mov dl, al          ; DL now holds 1st char for immediate printing

    ; Print 1st character
    mov ah, 02h
    int 21h

    ; Print " , "
    mov dx, offset results2
    call printstring

    ; Print 2nd character
    mov dl, cl
    mov ah, 02h
    int 21h

    ; Print " and "
    mov dx, offset results3
    call printstring

    ; Print 3rd character
    mov dl, bl
    mov ah, 02h
    int 21h

    ; Print "."
    mov dx, offset results4
    call printstring

    ; Standard Exit
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