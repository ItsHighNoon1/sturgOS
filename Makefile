

all: boot.bin

clean:
	rm -f boot.bin
	rm -f *.o

boot.bin: bootsect_main.asm bootsect_print.asm bootsect_print32.asm bootsect_gdt.asm bootsect_32bit.asm bootsect_disk.asm
	nasm -f bin bootsect_main.asm -o boot.bin
