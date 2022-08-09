[bits 32]
[extern main]
	call main ; need one more piece of assembly to find main in the linker
	jmp $
