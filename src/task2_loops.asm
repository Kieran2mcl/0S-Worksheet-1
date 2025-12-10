%include "asm_io.inc"

segment .data
    i dd 5

segment .text
global asm_main

asm_main:
    enter 0,0
    pusha

while_start:
    mov eax, [i]
    cmp eax, 0
    jle while_end      ; exit loop if i <= 0

    dec eax
    mov [i], eax
    jmp while_start

while_end:
    mov eax, [i]
    call print_int
    call print_nl

    popa
    mov eax, 0
    leave
    ret
