; SPDX-License-Identifier: BSD-3-Clause

section .rodata
    prompt db "Introduce N: ", 0
    scanf_format db "%lu", 0
    printf_format db "Product is: %lu", 10, 0

section .text

extern printf
extern scanf
global main

sum_n:
    ; Initialize counter to 1st argument.
    mov rcx, rdi

    ; Initialize accumulating register to 0.
    xor rax, rax

    ; Compute sum in accumulating register.
.again:
    add rax, rcx
    loopnz .again

    ret

read_compute_sum:
    push rbp
    mov rbp, rsp

    ; Allocate space on the stack. Keep it 16 bytes-alligned.
    ; Allocate space for:
    ; - N (unsigned long, 8 bytes): address is [rbp-16].
    sub rsp, 16

    ; Print prompt.
    lea rdi, [prompt]
    call printf

    ; Read N using scanf.
    lea rdi, [scanf_format]
    lea rsi, [rbp-16]
    call scanf

    ; Call sum_n to compute first sum of first N natural numbers.
    mov rdi, [rbp-16]
    call sum_n

    ; Returned value (sum) is in rax, nothing more to do.

    leave
    ret

main:
    push rbp
    mov rbp, rsp

    ; Allocate space on the stack. Keep it 16 bytes-alligned.
    ; Allocate space for:
    ; - sum1 (unsigned long, 8 bytes): adress is [rbp-8]
    ; - sum2 (unsigned long, 8 bytes): address is [rbp-16]
    sub rsp, 16

    ; Call read_compute_sum first time (no arguments).
    ; Store result in sum1 variable (at rbp-8).
    call read_compute_sum
    mov [rbp-8], rax

    ; Call read_compute_sum first time (no arguments).
    ; Store result in sum1 variable (at rbp-16).
    call read_compute_sum
    mov [rbp-16], rax

    ; Compute product of two sums (sum1: [rbp-8], sum2: [rbp-16).
    ; Result is in rdx:rax.
    mov rax, [rbp-8]
    mul qword [rbp-16]

    ; Print product. We only print rax.
    lea rdi, [printf_format]
    mov rsi, rax
    call printf

    leave
    ret
