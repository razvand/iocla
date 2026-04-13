section .text
global main

empty:
    ret

main:
    push rbp
    mov rbp, rsp

    call empty
    call empty
    call empty

    leave
    ret
