// Using write to /dev/null - measures pure syscall overhead
#include <unistd.h>

int main() {
    char msg[] = "hello world!\n";
    write(1, msg, 13);
    return 0;
}