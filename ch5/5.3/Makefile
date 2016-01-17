BOOT_ASM_FILES = $(wildcard boot/*.asm)
boot/boot_sect.bin: ${BOOT_ASM_FILES}
	cd boot && nasm -f bin boot_sect.asm -o boot_sect.bin

C_SOURCES = $(wildcard kernel/*.c)
OBJ = ${C_SOURCES:.c=.o}
kernel/kernel.bin: kernel/kernel_entry.o ${OBJ}
	ld -melf_i386 -o $@ -Ttext 0x1000 $^ --oformat binary
%.o : %.c
	gcc -m32 -ffreestanding -c $^ -o $@
%.o : %.asm
	nasm $^ -f elf -o $@

os-image: boot/boot_sect.bin kernel/kernel.bin
	cat $^ > $@

all: os-image

run: os-image
	qemu-system-i386 os-image

clean:
	rm -f boot/*.bin kernel/*.bin kernel/*.o os-image
