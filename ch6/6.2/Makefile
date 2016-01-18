CC     = gcc
CFLAGS = -std=c99 -m32 -ffreestanding -c
LFLAGS = -melf_i386 -Ttext 0x1000 --oformat binary

BOOT_SOURCES = $(wildcard boot/*.s)
boot/boot_sect.bin: ${BOOT_SOURCES}
	cd boot && nasm -f bin boot_sect.s -o boot_sect.bin

C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
S_SOURCES = $(wildcard kernel/*.s drivers/*.s)
OBJ = ${C_SOURCES:.c=.o} ${S_SOURCES:.s=.o}

kernel/kernel.bin: ${OBJ}
	ld $(LFLAGS) -o $@ $^

%.o : %.c
	$(CC) $(CFLAGS) $^ -o $@

%.o : %.s
	nasm $^ -f elf -o $@

os-image: boot/boot_sect.bin kernel/kernel.bin
	cat $^ > $@ && truncate -s '>3k' $@

all: os-image

run: os-image
	qemu-system-i386 os-image

clean:
	rm -f boot/*.bin kernel/*.bin kernel/*.o drivers/*.o os-image
