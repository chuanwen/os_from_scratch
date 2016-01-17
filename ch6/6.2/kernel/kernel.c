#include "../drivers/screen.h"

void main() {
    char *msg = "Hello world from main() in kernel.c \nStart_new_line here .....";
    k_set_cursor(23, 0);
    k_print(msg);
    k_print("\n\tThere is a tab in the left.");
}
