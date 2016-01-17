print_string:
    push si
    mov si, bx
    mov ah, 0x0e
.repeat:
    lodsb
    cmp al, 0
    je .exit
    int 0x10
    jmp .repeat
.exit:
    pop si
    ret
