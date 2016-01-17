; A simple boot sector program
; - use bios to read disk

    [org 0x7c00]
    mov [BOOT_DRIVE], dl        ; BIOS stores boot drive in DL, save it.
    mov bp, 0x8000              ; Set the base of the stack.
    mov sp, bp                  ; Stack is empty now.

    xor ax, ax
    mov es, ax
    mov bx, 0x9000              ; Load 2 sectors to 0x0000(ES): 0x9000(BX)
    mov dh, 2
    mov dl, [BOOT_DRIVE]
    mov cl, 0x02                ; Start reading from second sector (i.e. after
    call load_disk              ; the boot sector).

    mov bx, [0x9000]
    call print_hex

    mov bx, [0x9000+512]
    call print_hex

    jmp $

%include "load_disk.asm"
%include "print.asm"

BOOT_DRIVE:
    db 0

    times 510-($-$$) db 0           ; $$: location of the section
    dw 0xaa55

    times 256 dw 0xdada
    times 256 dw 0xface
