; A simple boot sector program
; - use stack
; - functions in asm

    [org 0x7c00]
    mov bp, 0x8000              ; set the base of the stack
    mov sp, bp                  ; stack is empty now

    mov bx, HELLO_MSG
    call print_str

    mov bx, GOODBY_MSG
    call print_str

    mov bx, 0x1fb6
    call print_hex

    jmp $

%include "print.asm"

HELLO_MSG:
    db 'Hello, World!', 13, 10, 0   ; 13 and 10 are for new line.
GOODBY_MSG:
    db 'Good-bye!', 0
    times 510-($-$$) db 0           ; $$: location of the section
    dw 0xaa55
