ASM_FILES = $(wildcard *.asm)

boot_sect.bin: ${ASM_FILES}
	nasm -f bin boot_sect.asm -o boot_sect.bin

os-image: boot_sect.bin kernel.bin
	cat $^ > $@ && chmod +x $@

kernel.bin: kernel_entry.o kernel.o
	ld -melf_i386 -o $@ -Ttext 0x1000 $^ --oformat binary && chmod -x $@

%.o : %.c
	gcc -m32 -ffreestanding -c $^ -o $@
%.o : %.asm
	nasm $^ -f elf -o $@

clean:
	rm -f *.bin *.o os-image
