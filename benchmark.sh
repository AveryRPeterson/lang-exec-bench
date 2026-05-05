#!/bin/bash

# Benchmark script to compare runtime of hello scripts in different languages
# Scripts to benchmark:
# - hello.sh (Bash)
# - hello.rb (Ruby)
# - hello (Rust compiled)
# - hello.js (JSX/React bundled)

ITERATIONS=100
SCRIPT_DIR="/workspace/project"

echo "========================================"
echo "Hello Scripts Execution Benchmark"
echo "========================================"
echo "Iterations per script: $ITERATIONS"
echo ""

# Function to measure execution time
benchmark() {
    local name=$1
    local cmd=$2
    local total=0
    
    echo -n "Benchmarking $name... "
    
    for ((i=0; i<ITERATIONS; i++)); do
        start=$(date +%s%N)
        eval "$cmd" > /dev/null 2>&1
        end=$(date +%s%N)
        ((total += end - start))
    done
    
    # Calculate average in nanoseconds, convert to microseconds
    avg_ns=$((total / ITERATIONS))
    avg_us=$((avg_ns / 1000))
    avg_ms=$(echo "scale=3; $avg_us / 1000" | bc 2>/dev/null || echo "$((avg_us / 1000)).$((avg_us % 1000))")
    
    echo "${avg_ms}ms (${avg_us}μs)"
}

# Check which scripts exist and benchmark them
echo "Running benchmarks..."
echo "----------------------------------------"

# Bash
if [ -x "$SCRIPT_DIR/hello.sh" ]; then
    benchmark "Bash (hello.sh)" "$SCRIPT_DIR/hello.sh"
fi

# Ruby
if command -v ruby >/dev/null 2>&1 && [ -f "$SCRIPT_DIR/hello.rb" ]; then
    benchmark "Ruby (hello.rb)" "ruby $SCRIPT_DIR/hello.rb"
fi

# Rust (compiled binary)
if [ -x "$SCRIPT_DIR/hello" ]; then
    benchmark "Rust (hello)" "$SCRIPT_DIR/hello"
fi

# C (compiled)
if [ -x "$SCRIPT_DIR/hello_c" ]; then
    benchmark "C (hello.c)" "$SCRIPT_DIR/hello_c"
fi

# Inline Assembly (C with inline asm)
if [ -x "$SCRIPT_DIR/hello_inline_asm" ]; then
    benchmark "Inline Assembly (C)" "$SCRIPT_DIR/hello_inline_asm"
fi

# Pure syscall (write)
if [ -x "$SCRIPT_DIR/hello_write" ]; then
    benchmark "Pure syscall (write)" "$SCRIPT_DIR/hello_write"
fi

# puts() from libc
if [ -x "$SCRIPT_DIR/hello_puts" ]; then
    benchmark "puts() libc" "$SCRIPT_DIR/hello_puts"
fi

# Static binary
if [ -x "$SCRIPT_DIR/hello_opt_static" ]; then
    benchmark "Static binary (-O3)" "$SCRIPT_DIR/hello_opt_static"
fi

# musl-libc static
if [ -x "$SCRIPT_DIR/hello_musl" ]; then
    benchmark "musl-libc static" "$SCRIPT_DIR/hello_musl"
fi

# Assembly (NASM assembled)
if [ -x "$SCRIPT_DIR/hello_asm" ]; then
    benchmark "Assembly (NASM)" "$SCRIPT_DIR/hello_asm"
fi

# GNU as (gas) - default assembler
if [ -x "$SCRIPT_DIR/hello_gas" ]; then
    benchmark "GNU as (default)" "$SCRIPT_DIR/hello_gas"
fi

# Go (compiled binary)
if [ -x "$SCRIPT_DIR/hello_go" ]; then
    benchmark "Go (hello_go)" "$SCRIPT_DIR/hello_go"
fi

# Python
if command -v python3 >/dev/null 2>&1 && [ -f "$SCRIPT_DIR/hello.py" ]; then
    benchmark "Python (hello.py)" "python3 $SCRIPT_DIR/hello.py"
fi

# JSX/React (Node.js bundled)
if command -v node >/dev/null 2>&1 && [ -f "$SCRIPT_DIR/hello.js" ]; then
    benchmark "JSX/React (hello.js)" "node $SCRIPT_DIR/hello.js"
fi

echo "----------------------------------------"
echo "Benchmark complete!"
echo "========================================"