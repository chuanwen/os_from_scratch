#pragma once

#include "../kernel/low_level.h"

#define SCREEN_CTRL_PORT 0x3D4
#define SCREEN_DATA_PORT 0x3D5
#define VIDEO_ADDRESS 0xb8000
#define MAX_COLS 80
#define MAX_ROWS 25
#define DEFAULT_COLOR 0x07

void k_print(char* msg);
void k_set_cursor(int row, int col);
void k_clear_screen();

void _set_cursor(int offset);
void _memcpy(char* dest, char* src, int size);
int _get_cursor();
int _next_line(int offset);
int _next_tab(int offset);
int _handle_scrolling(int offset);
