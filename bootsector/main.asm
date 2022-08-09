[org 0x7c00]
KERNEL_LOC equ 0x1000

	mov [BOOT_DRIVE], dl
	mov bp, 0x9000
	mov sp, bp

	mov bx, BIT16
	call print
	call print_flush

	call load_kernel
	call switch_to_32

	jmp $ ; uh oh, looks like we are stuck in 16 bit hell, i will now overheat your pc

%include "bootsector/print.asm"
%include "bootsector/disk.asm"
%include "bootsector/gdt.asm"
%include "bootsector/print32.asm"
%include "bootsector/32bit.asm"

[bits 16]
load_kernel:
	mov bx, KERNEL_LOC
	mov dh, 2
	mov dl, [BOOT_DRIVE]
	call disk_load
	ret

[bits 32]
begin_32:
	mov ebx, BIT32
	call print32
	call KERNEL_LOC ; asm is gone!
	jmp $


BOOT_DRIVE db 0
BIT16 db "16 bit mode", 0
BIT32 db "32 bit mode", 0

; boot sector requires that bytes 511 and 512 are 0xAA and 0x55
times 510-($-$$) db 0
dw 0xaa55
