#include "screen.h"

void k_print(char* msg) {
    int offset = _get_cursor();
    char* vidmem = (char*) VIDEO_ADDRESS;
    int i = 0;
    const int max_char = 512;
    while (*msg) {
        switch(*msg) {
            case '\n':
                offset = _next_line(offset);
                break;
            case '\t':
                offset = _next_tab(offset);
                break;
            default:
                vidmem[offset++] = *msg;
                vidmem[offset++] = DEFAULT_COLOR;
        }
        offset = _handle_scrolling(offset);
        msg++;
        i++;
        if (i >= max_char) break;
    }
     _set_cursor(offset);
}

void k_set_cursor(int row, int col) {
    int offset = 2 * (MAX_COLS * row + col);
    _set_cursor(offset);
}

void k_clear_screen() {
    char * vidmem = (char*) VIDEO_ADDRESS;
    for (int i = 0; i < MAX_COLS * MAX_ROWS; i++) {
        *(vidmem++) = 0;
        *(vidmem++) = DEFAULT_COLOR;
    }
    _set_cursor(0);
}


int _get_cursor() {
    int offset;
    outb(SCREEN_CTRL_PORT, 14);
    offset = inb(SCREEN_DATA_PORT) << 8;
    outb(SCREEN_CTRL_PORT, 15);
    offset += inb(SCREEN_DATA_PORT);
    return offset*2;
}

void _set_cursor(int offset) {
    offset /= 2;
    outb(SCREEN_CTRL_PORT, 14);
    outb(SCREEN_DATA_PORT, (uint8_t) ((offset >> 8) & 0xFF));
    outb(SCREEN_CTRL_PORT, 15);
    outb(SCREEN_DATA_PORT, (uint8_t) (offset & 0xFF));
}

int _next_line(int offset) {
    offset /= 2;
    int row = offset / MAX_COLS;
    int col = offset % MAX_COLS;
    return 2 * (row + 1) * MAX_COLS;
}

int _next_tab(int offset) {
    return (offset / 16) * 16 + 16;
}

void _memcpy(char* dest, char* src, int size) {
    for (int i = 0; i < size; i++) dest[i] = src[i];
}

int _handle_scrolling(int offset) {
    if (offset < MAX_COLS * MAX_ROWS * 2) {
        return offset;
    }

    char *dest = (char *) VIDEO_ADDRESS;
    char *src = (char *) VIDEO_ADDRESS + MAX_COLS * 2;
    int size = 2 * MAX_COLS * (MAX_ROWS - 1);
    _memcpy(dest, src, size);

    // Handle last line.
    offset = size;
    char *p = (char *) VIDEO_ADDRESS + offset;
    for (int i = 0; i < MAX_COLS; i++) {
        *(p++) = ' ';
        *(p++) = DEFAULT_COLOR;
    }
    return offset;
}
