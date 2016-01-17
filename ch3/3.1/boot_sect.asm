; A simple boot sector program that loops forever

    jmp $                   ; $: current location.
    times 510-($-$$) db 0   ; $$: location of the section
    dw 0xaa55
