// Hello world with inline assembly - bypasses glibc overhead
#include <stdio.h>

int main() {
    // Inline assembly to directly invoke syscall
    // RAX=1 (write), RDI=1 (fd), RSI=ptr, RDX=len
    __asm__ __volatile__ (
        "mov $1, %%rax\n\t"
        "mov $1, %%rdi\n\t"
        "mov %0, %%rsi\n\t"
        "mov $13, %%rdx\n\t"
        "syscall"
        :: "r" ("hello world!\n") : "rax", "rdi", "rsi", "rdx"
    );
    return 0;
}