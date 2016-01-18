[bits 32]

VIDEO_ADDR equ 0xb8000
GRAY_ON_BLUE equ 0x17

print_str_pm:
    pusha
    mov edx, VIDEO_ADDR
.loop:
    mov al, [ebx]
    mov ah, GRAY_ON_BLUE
    cmp al, 0
    je .done
    mov [edx], ax
    add ebx, 1
    add edx, 2
    jmp .loop
.done:
    popa
    ret
