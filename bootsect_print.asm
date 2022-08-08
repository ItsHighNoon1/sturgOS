print:
	pusha ; save existing registers

	print_start:
		mov al, [bx] ; bx is starting addr
		cmp al, 0
		je print_done

		mov ah, 0x0e ; tty
		int 0x10 ; video int

		add bx, 1
		jmp print_start

	print_done:
	popa ; get the registers back
	ret

print_hex:
	pusha

	mov cx, 0

	print_hex_loop:
		cmp cx, 4 ; 4 chars
		je print_hex_end

		mov ax, dx
		and ax, 0x000f ; lowest 4 bits
		add al, 0x30 ; n + '0'
		cmp al, 0x39
		jle print_hex_skip_alpha ; if <= 9, dont convert to a letter
		add al, 7 ; n + ('A' - '0')

	print_hex_skip_alpha:
	mov bx, HEX_OUT + 5
	sub bx, cx
	mov [bx], al
	ror dx, 4 ; >> 4

	add cx, 1
	jmp print_hex_loop

	print_hex_end:
	mov bx, HEX_OUT
	call print

	popa
	ret

print_flush:
	pusha

	mov ah, 0x0e
	mov al, 0x0a ; \n
	int 0x10
	mov al, 0x0d ; \r
	int 0x10

	popa
	ret

HEX_OUT: db "0x0000", 0 ; reserved space for hex print
