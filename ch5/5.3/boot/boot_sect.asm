; A simple boot sector program
; - use bios to read disk

[org 0x7c00]
KERNEL_OFFSET equ 0x1000

    mov [BOOT_DRIVE], dl        ; BIOS stores boot drive in DL, save it.
    mov bp, 0x8000              ; Set the base of the stack.
    mov sp, bp                  ; Stack is empty now.

    mov bx, MSG_REAL_MODE
    call print_str

    call load_kernel

    call switch_to_pm           ; Note that we never return here
    jmp $

%include "load_disk.asm"
%include "print.asm"
%include "gdt.asm"
%include "switch_to_pm.asm"
%include "print_pm.asm"

[bits 16]
load_kernel:
    mov bx, MSG_LOAD_KERNEL
    call print_str
    xor ax, ax
    mov es, ax
    mov bx, KERNEL_OFFSET       ; Load to ES:BX
    mov dh, 1                   ; Number of sectors to load.
    mov dl, [BOOT_DRIVE]
    mov cl, 0x02                ; Start from 2nd sector (after boot sector).
    call load_disk
    ret

[bits 32]
BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_str_pm
    call KERNEL_OFFSET
    jmp $

BOOT_DRIVE:
    db 0
MSG_REAL_MODE:
    db 13, 10, "Started in real mode", 13, 10, 0
MSG_LOAD_KERNEL:
    db "Loading kernel into memory", 13, 10, 0
MSG_PROT_MODE:
    db "Successfully Landed in 32-bit Protected Mode.........", 0

    times 510-($-$$) db 0           ; $$: location of the section
    dw 0xaa55
