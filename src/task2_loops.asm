%include "asm_io.inc"

segment .data
    name_msg db "Welcome, student!", 0
    ask_count db "How many times (50–100)? ", 0
    err_msg db "Error: number must be between 50 and 100.", 0

segment .bss
    count resd 1

segment .text
global asm_main

asm_main:
    enter 0,0
    pusha

    ; Ask for repetition count
    mov eax, ask_count
    call print_string
    call read_int
    mov [count], eax

    ; Validate lower bound (>= 50)
    cmp eax, 50
    jl invalid

    ; Validate upper bound (<= 100)
    cmp eax, 100
    jg invalid

    ; Loop count = eax
    mov ecx, eax          ; repetitions
welcome_loop:
    mov eax, name_msg
    call print_string
    call print_nl
    loop welcome_loop
    jmp finish

invalid:
    mov eax, err_msg
    call print_string
    call print_nl

finish:
    popa
    mov eax, 0
    leave
    ret
