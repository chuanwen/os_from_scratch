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

    mov bx, MSG_REAL_MODE
    call print_str

    call switch_to_pm           ; Note that we never return here
    jmp $

%include "load_disk.asm"
%include "print.asm"
%include "gdt.asm"
%include "switch_to_pm.asm"
%include "print_pm.asm"

[bits 32]
BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_str_pm
    jmp $

BOOT_DRIVE:
    db 0
MSG_REAL_MODE:
    db 13, 10, "Started in real mode", 13, 10, 0
MSG_PROT_MODE:
    db "Successfully Landed in 32-bit Protected Mode.........", 0

    times 510-($-$$) db 0           ; $$: location of the section
    dw 0xaa55

    times 256 dw 0xdada
    times 256 dw 0xface
