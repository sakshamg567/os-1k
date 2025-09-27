#!/bin/bash
set -xue

QEMU=qemu-system-riscv32

# Path to clang and compiler flags
CC=clang
CFLAGS="-std=c11 -O2 -g3 -Wall -Wextra --target=riscv32-unknown-elf -fno-stack-protector -ffreestanding -nostdlib"
# --std=c11 - uses c11
# -02 - optimizations 
# -g3 - max debug info
# -Wall - enable major warnings
# -Wextra  - extra warnings
# --target=... - build for 32 bit risc-v
# ffreestanding - no standard library
# fno-stack-protector - disable stack protection
# nostdlib - no stdlib linking

# Build the kernel
$CC $CFLAGS -Wl,-Tkernel.ld -Wl,-Map=kernel.map -o kernel.elf \
    kernel.c common.c

# Start QEMU
$QEMU -machine virt -bios default -nographic -serial mon:stdio --no-reboot \
    -kernel kernel.elf
