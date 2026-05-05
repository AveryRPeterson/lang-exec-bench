# Language Execution Benchmark

A comprehensive benchmark comparing the execution time of "Hello World" programs across multiple programming languages and compilation strategies.

![Benchmark Results](https://img.shields.io/badge/Performance-1.60ms%20%28fastest%29-blue)

## Quick Start

```bash
# Run the benchmark
./benchmark.sh
```

## Benchmark Results

Latest results from running 100 iterations of each "hello world" implementation:

| Rank | Language/Method | Time (ms) | Category |
|------|--------------|----------|----------|
| 1 | Assembly (NASM) | 1.60 | Compiled - Zero Deps |
| 2 | GNU as (default) | 1.60 | Compiled - Zero Deps |
| 3 | musl-libc static | 1.62 | Compiled - Zero Deps |
| 4 | Static binary (-O3) | 1.80 | Compiled - No Runtime |
| 5 | Pure syscall (write) | 1.99 | Compiled - Minimal Libc |
| 6 | C (glibc) | 1.99 | Compiled - Libc |
| 7 | Inline Assembly (C) | 1.97 | Compiled - Libc |
| 8 | puts() libc | 1.99 | Compiled - Libc |
| 9 | Rust | 2.23 | Compiled - Stdlib |
| 10 | Bash | 2.71 | Interpreted |
| 11 | Go | 2.86 | Compiled - Stdlib |
| 12 | Python | 13.86 | Interpreted |
| 13 | JSX/React (Node.js) | 48.82 | Interpreted/JIT |
| 14 | Ruby | 56.51 | Interpreted |

## Categories

### Compiled + Zero Dependencies
No external libraries or runtime needed - fastest execution:
- Assembly (NASM) - x86_64 direct syscall
- GNU as - AT&T syntax assembly
- musl-libc static - lightweight C library

### Compiled + Minimal Libc
Standard C compilation with minimal overhead:
- C with write() syscall
- C with puts()
- Inline assembly in C

### Compiled + Full Stdlib
Languages with larger standard libraries:
- Rust
- Go

### Interpreted
Requires runtime interpreter:
- Bash
- Python
- Ruby

### Interpreted/JIT
Just-in-time compilation:
- JavaScript/JSX (Node.js)

## Source Files

All source implementations are in `src/`:

```
src/
├── hello.sh          # Bash script
├── hello.rb         # Ruby script  
├── hello.py         # Python script
├── hello.rs         # Rust source
├── hello.go         # Go source
├── hello.c         # C source
├── hello.asm       # NASM assembly
├── hello_gas.s     # GNU as assembly
├── hello.jsx       # React/JSX source
└── hello.rb       # Ruby source
```

## Building

Each implementation can be built individually:

```bash
# C
gcc hello.c -o hello_c

# Rust
rustc hello.rs -o hello_rust

# Go
go build -o hello_go hello.go

# Assembly (NASM)
nasm -f elf64 hello.asm -o hello.o
ld hello.o -o hello_asm

# Assembly (GNU as)
as hello_gas.s -o hello_gas.o
ld hello_gas.o -o hello_gas

# JavaScript/JSX
npx esbuild hello.jsx --bundle --outfile=hello.js --platform=node

# musl-libc
musl-gcc -static hello.c -o hello_musl

# Static C
gcc -O3 -static hello.c -o hello_static
```

## Requirements

### Default (pre-installed on most Linux)
- `gcc` - C compiler
- `python3` - Python interpreter
- `as` - GNU assembler (part of binutils)

### Optional (faster results)
- `rustc` - Rust compiler
- `go` - Go compiler  
- `nasm` - NASM assembler
- `ruby` - Ruby interpreter
- `node` - Node.js runtime
- `musl-gcc` - musl-libc compiler

## Methodology

The benchmark measures wall-clock time for 100 iterations of each "hello world" program using `date +%s%N` for nanosecond precision:

```bash
for ((i=0; i<100; i++)); do
    start=$(date +%s%N)
    ./hello
    end=$(date +%s%N)
done
```

## Key Findings

1. **Assembly is fastest** - Direct kernel syscall with zero overhead
2. **Static linking helps** - Eliminates dynamic loader
3. **musl-libc is lighter** - Smaller/faster than glibc
4. **Interpreted varies widely** - Shell is pre-loaded, Python is optimized
5. **Heavy runtimes slow down** - Node.js and Ruby have significant overhead

## License

MIT License