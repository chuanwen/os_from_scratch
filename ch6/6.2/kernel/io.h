#pragma once

#include <stdint.h>

/** outb:
 * Sends the given data to the given I/O port. Defined in io.s
 *
 * @param port The I/O port to send the data to
 * @param data The data to send
 */
void outb(uint16_t port, uint8_t data);

/** inb:
 * Receive a byte from the given I/O port. Defined in io.s
 *
 * @param port The I/O port to receive data
 */
uint8_t inb(uint16_t port);

/** outw:
 * Sends the given data to the given I/O port. Defined in io.s
 *
 * @param port The I/O port to send the data to
 * @param data The data to send
 */
void outw(uint16_t port, uint16_t data);

/** inb:
 * Receive a byte from the given I/O port. Defined in io.s
 *
 * @param port The I/O port to receive data
 */
uint16_t inw(uint16_t port);
