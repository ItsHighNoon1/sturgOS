; https://stanislavs.org/helppc/int_13-2.html
disk_load:
	pusha

	push dx
	
	mov ah, 0x02 ; read
	mov al, dh ; num of sectors to read
	mov cl, 0x02 ; 0x02 is first available sector (boot sector is 0x01)
	mov ch, 0x00 ; cylinder
	; dl is drive number
	mov dh, 0x00 ; head number (multiple platters)

	int 0x13 ; bios int
	jc disk_error ; carry bit is set if there is an error

	pop dx
	cmp al, dh
	jne disk_sector_error ; number of sectors actually read stored in al

	popa
	ret

disk_error:
	mov bx, DISK_ERROR
	call print
	mov dh, ah
	call print_hex
	call print_flush
	jmp $

disk_sector_error:
	mov bx, SECTOR_ERROR
	call print
	mov dh, al
	call print_hex
	call print_flush

DISK_ERROR: db "Error reading disk ", 0
SECTOR_ERROR: db "Read wrong number of sectors ", 0
