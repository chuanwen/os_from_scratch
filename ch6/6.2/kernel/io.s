global outb, inb, outw, inw

; outb - send a byte to an I/O port
; stack: [esp + 8] the data byte
;        [esp + 4] the I/O port
;        [esp    ] return address
outb:
    mov al, [esp + 8]
    mov dx, [esp + 4]
    out dx, al
    ret

; inb - receive a byte from the given I/O port
; stack: [esp + 4] the I/O port
;        [esp    ] return address
inb:
    mov dx, [esp + 4]
    in al, dx
    ret

; outw - send a byte to an I/O port
; stack: [esp + 8] the data byte
;        [esp + 4] the I/O port
;        [esp    ] return address
outw:
    mov ax, [esp + 8]
    mov dx, [esp + 4]
    out dx, ax
    ret

; inw - receive a word from the given I/O port
; stack: [esp + 4] the I/O port
;        [esp    ] return address
inw:
    mov dx, [esp + 4]
    in ax, dx
    ret
