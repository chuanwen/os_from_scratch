/* 
 * low_level.c
 * In the PDF, functions are named like "port_byte_in", "port_byte_out", ...
 * here we name the functions as "inb", "outb", "inw", "outw".
 */

#include "low_level.h"

uint8 inb(uint16 port) {
    uint8 result;
    __asm__("in %%dx, %%al" : "=a" (result) : "d" (port));
    return result;
}

void outb(uint16 port, uint8 data) {
    __asm__("out %%al, %%dx" : : "a" (data), "d" (port));
}

uint16 inw(uint16 port) {
    uint16 result;
    __asm__("in %%dx, %%ax" : "=a" (result) : "d" (port));
    return result;
}

void outw(uint16 port, uint16 data) {
    __asm__("out %%ax, %%dx" : : "a" (data), "d" (port));
}
