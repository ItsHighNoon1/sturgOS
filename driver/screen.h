#define VID_ADDR (char*)0xb8000
#define VID_ROWS 25
#define VID_COLS 80
#define VID_WHITE 0x0f
#define VID_RED 0xf4

#define PORT_SCREEN_CTRL 0x3d4
#define PORT_SCREEN_DATA 0x3d5

void screen_clear();
void screen_print(char* message);
void screen_print_at(char* message, int col, int row);
