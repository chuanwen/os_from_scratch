print_char:         ; BL has the char
    mov ah, 0x0e
    mov al, bl
    int 0x10
    ret

print_str:          ; BX has the string address
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

print_hex:          ; BX has the 16-bit hex value
    push di
    push bx
    mov di, .HEXOUT + 2
    mov al, bh
    shr al, 4
    call .tochar
    mov al, bh
    and al, 0x0f
    call .tochar
    mov al, bl
    shr al, 4
    call .tochar
    mov al, bl
    and al, 0x0f
    call .tochar
    mov bx, .HEXOUT
    call print_str
    pop bx
    pop di
    ret
.tochar:
    add al, '0'
    cmp al, '9'
    jle .done
    add al, 'a'-'0'-10
.done:
    mov [di], al
    inc di
    ret
.HEXOUT:
    db '0x0000 ', 0
