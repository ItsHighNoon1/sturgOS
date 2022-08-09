[bits 32]

VMEM equ 0xb8000
WHITE_ON_BLACK equ 0x0f ; color byte

print32:
	pusha
	mov edx, VMEM

	print32_loop:
		mov al, [ebx]
		mov ah, WHITE_ON_BLACK
	
		cmp al, 0
		je print32_done

		mov [edx], ax
		add ebx, 1
		add edx, 2

		jmp print32_loop

	print32_done:
	popa
	ret
