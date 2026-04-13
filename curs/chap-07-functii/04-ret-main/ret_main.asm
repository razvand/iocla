; SPDX-License-Identifier: BSD-3-Clause

global main

main:
    push rbp
    mov rbp, rsp

    mov rax, 42

    leave
    ret
