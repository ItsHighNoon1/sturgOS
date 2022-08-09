C_SOURCES = $(wildcard kernel/*.c driver/*.c)
HEADERS = $(wildcard kernel/*.h driver/*.h)
OBJ = ${C_SOURCES:.c=.o}

CFLAGS = -Wall -std=c99 -I.

all: os.bin run

os.bin: bootsector.bin kernel.bin
	cat $^ > $@
run: os.bin
	qemu-system-x86_64 $<
clean:
	rm -f *.bin
	rm -f **/*.o

bootsector.bin: bootsector/main.asm bootsector/print.asm bootsector/disk.asm bootsector/print32.asm bootsector/gdt.asm bootsector/32bit.asm
	nasm -f bin $< -o $@
kernel.bin: bootsector/kentry.o ${OBJ}
	ld -o $@ -Ttext 0x1000 $^ --oformat binary

%.o: %.c ${HEADERS}
	gcc -ffreestanding -c $< -o $@
%.o: %.asm
	nasm $< -felf64 -o $@
