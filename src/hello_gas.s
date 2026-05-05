# Hello world in x86_64 AT&T syntax using GNU as (gas)
.section .data
msg:
    .ascii "hello world!\n"

.section .text
    .globl _start
_start:
    movl $1, %eax        # syscall: write (syscall number 1)
    movl $1, %edi        # fd: stdout
    movl $msg, %esi      # buffer: address of msg
    movl $13, %edx      # length: 13 bytes
    syscall

    movl $60, %eax       # syscall: exit (syscall number 60)
    movl $0, %edi       # status: 0
    syscall