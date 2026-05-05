; Hello world in x86_64 Linux assembly
section .data
    msg db "hello world!", 10

section .text
    global _start

_start:
    mov rax, 1              ; syscall: write
    mov rdi, 1              ; fd: stdout
    mov rsi, msg            ; buffer: msg
    mov rdx, 13            ; length: 13
    syscall

    mov rax, 60             ; syscall: exit
    xor rdi, rdi            ; status: 0
    syscall