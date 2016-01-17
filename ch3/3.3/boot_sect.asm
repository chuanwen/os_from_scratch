; A simple boot sector program that prints a message using BIOS routine.

    mov ah, 0x0e
    mov al, 'H'
    int 0x10
    mov al, 'e'
    int 0x10
    mov al, 'l'
    int 0x10
    mov al, 'l'
    int 0x10
    mov al, 'o'
    int 0x10

    jmp $
    times 510-($-$$) db 0   ; $$: location of the section
    dw 0xaa55
