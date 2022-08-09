#include "screen.h"

#include <driver/port.h>

int get_offset(int col, int row) {
	return 2 * (row * VID_COLS + col);
}

int get_vga_offset() {
	port_putb(PORT_SCREEN_CTRL, 14);
	int offset = port_getb(PORT_SCREEN_DATA) << 8;
	port_putb(PORT_SCREEN_CTRL, 15);
	offset += port_getb(PORT_SCREEN_DATA) << 8;
	return offset * 2;
}

void set_vga_offset(int offset) {
	offset /= 2;
	port_putb(PORT_SCREEN_CTRL, 14);
	port_putb(PORT_SCREEN_CTRL, (unsigned char)(offset >> 8));
	port_putb(PORT_SCREEN_CTRL, 15);
	port_putb(PORT_SCREEN_CTRL, (unsigned char)(offset & 0xff));
}

void screen_clear() {
	int screen_size = VID_COLS * VID_ROWS;
	char* scr = VID_ADDR;
	for (int i = 0; i < screen_size; i++) {
		scr[i * 2] = 'C';
		scr[i * 2 + 1] = 'A';
	}
	set_vga_offset(get_offset(0, 0));
}
