[bits 16]
switch_to_32:
	cli ; no more interrupts!
	lgdt [gdt_descriptor]
	mov eax, cr0
	or eax, 0x1
	mov cr0, eax ; society if you could access cr0 with or
	jmp CODE_SEG:init_32

[bits 32]
init_32:
	mov ax, DATA_SEG ; point everything at the data segment
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	mov ebp, 0x90000 ; put the stack in REAL narnia
	mov esp, ebp

	call begin_32
