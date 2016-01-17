To compile:
    gcc -m32 -ffreestanding -c basic.c

To link:
    ld -melf_i386 -o basic.bin -Ttext 0x0 --oformat binary basic.o

Below is output of the "objdump -d" of the object files.

#####################################################################

basic.o:     file format elf32-i386


Disassembly of section .text:

00000000 <my_function>:
   0:   55                      push   %ebp
   1:   89 e5                   mov    %esp,%ebp
   3:   b8 ba ba 00 00          mov    $0xbaba,%eax
   8:   5d                      pop    %ebp
   9:   c3                      ret    


#####################################################################

local_var.o:     file format elf32-i386


Disassembly of section .text:

00000000 <my_function>:
   0:   55                      push   %ebp
   1:   89 e5                   mov    %esp,%ebp
   3:   83 ec 10                sub    $0x10,%esp
   6:   c7 45 fc ba ba 00 00    movl   $0xbaba,-0x4(%ebp)
   d:   8b 45 fc                mov    -0x4(%ebp),%eax
  10:   c9                      leave  
  11:   c3                      ret    

#####################################################################

call.o:     file format elf32-i386


Disassembly of section .text:

00000000 <caller>:
   0:   55                      push   %ebp
   1:   89 e5                   mov    %esp,%ebp
   3:   83 ec 18                sub    $0x18,%esp
   6:   c7 04 24 de de 00 00    movl   $0xdede,(%esp)
   d:   e8 fc ff ff ff          call   e <caller+0xe>
  12:   c9                      leave  
  13:   c3                      ret    

00000014 <callee>:
  14:   55                      push   %ebp
  15:   89 e5                   mov    %esp,%ebp
  17:   8b 45 08                mov    0x8(%ebp),%eax
  1a:   5d                      pop    %ebp
  1b:   c3                      ret    

