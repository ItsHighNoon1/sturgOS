[org 0x7c00]

	mov bp, 0x9000 ; start the stack in narnia (2kb lol)
	mov sp, bp

	mov bx, BIT16
	call print

	call switch_to_32

	mov bx, YOUDIED
	call print
	call print_flush
	jmp $ ; uh oh, looks like we are stuck in 16 bit hell, i will now overheat your pc

%include "bootsect_print.asm"
%include "bootsect_print32.asm"
%include "bootsect_gdt.asm"
%include "bootsect_32bit.asm"
%include "bootsect_disk.asm"

[bits 32]
begin_32:
	mov ebx, BIT32
	call print32
	jmp $

BIT16: db "Starting in 16 bit mode", 0
BIT32: db "Welcome to 1962", 0
YOUDIED: db "Failed to switch to 32 bit mode", 0

; boot sector requires that bytes 511 and 512 are 0xAA and 0x55
times 510-($-$$) db 0
dw 0xaa55

; sector 2
times 256 dw 0xdada

; sector 3
times 256 dw 0xface
