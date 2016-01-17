void main() {
    char *msg = "Hello world from main() in kernel.c ~~~";
    char GRAY_ON_BLUE = 0x17;
    char *vidmem = (char*) 0xb8000 + 80*2; // start to print from 2nd row
    while(*msg) {
        *(vidmem++) = *msg;
        *(vidmem++) = GRAY_ON_BLUE;
        msg++;
    }
}
