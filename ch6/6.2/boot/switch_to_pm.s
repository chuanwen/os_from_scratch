; Switch to protected mode

[bits 16]
switch_to_pm:
    cli                     ; switch off interrupts until we have
                            ; set up the protected mode interrupt vector

    lgdt [gdt_descriptor]   ; Load our global descriptor table

    mov eax, cr0            ; Make the switch
    or eax, 0x1
    mov cr0, eax

    jmp CODE_SEG:init_pm    ; Make a far jump to 32-bit code. This force CPU
                            ; to flush its cache of pre-fetched code

[bits 32]
init_pm:
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000
    mov esp, ebp

    call BEGIN_PM
