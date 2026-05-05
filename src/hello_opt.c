// Optimized with -O3 and no stdio buffering - pure syscall
#include <unistd.h>

int main() {
    write(1, "hello world!\n", 13);
    return 0;
}