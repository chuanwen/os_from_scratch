load_disk:
    push dx
    mov ah, 0x02
    mov al, dh
    mov ch, 0x00
    mov dh, 0x00
    int 0x13
    jc .diskerror
    pop dx
    cmp dh, al
    jne .diskerror
    ret
.diskerror:
    mov bx, .DISK_ERROR_MSG
    call print_str
    jmp $
.DISK_ERROR_MSG:
    db "Disk read error!", 0
