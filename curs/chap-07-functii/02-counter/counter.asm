; SPDX-License-Identifier: BSD-3-Clause

%include "printf64.asm"

section .text

global main

counter:
    inc rcx
    ret

main:
    push rbp
    mov rbp, rsp

    ; Initialize rcx (counter) to 0.
    xor rcx, rcx

    ; Call counter() function to increment rcx.
    call counter
    call counter
    call counter

    ; Print counter.
    PRINTF64 `Counter is: %lu\n\0`, rcx

    leave
    ret
