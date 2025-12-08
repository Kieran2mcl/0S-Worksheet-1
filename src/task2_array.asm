%include "asm_io.inc"

segment .data
    prompt_start db "Enter start index (1–100): ", 0
    prompt_end   db "Enter end index (1–100): ", 0
    invalid_msg  db "Invalid range!", 0
    total_msg    db "Total sum (1–100): ", 0
    range_msg    db "Range sum: ", 0

segment .bss
    arr resd 100
    start resd 1
    range_end resd 1      ; renamed from 'finish' to avoid label conflict

segment .text
global asm_main

asm_main:
    enter 0,0
    pusha

    ; ---- initialize array with values 1–100 ----
    mov ecx, 100
    mov ebx, 1
init_loop:
    mov [arr + (ebx-1)*4], ebx
    inc ebx
    loop init_loop

    ; ---- sum entire array ----
    mov ecx, 100
    mov ebx, 0
    mov eax, 0
sum_loop:
    add eax, [arr + ebx*4]
    inc ebx
    loop sum_loop

    ; print full-array sum
    mov ebx, eax
    mov eax, total_msg
    call print_string
    mov eax, ebx
    call print_int
    call print_nl

    ; ---- ask for range ----
    mov eax, prompt_start
    call print_string
    call read_int
    mov [start], eax

    mov eax, prompt_end
    call print_string
    call read_int
    mov [range_end], eax

    ; ---- validate ----
    mov eax, [start]
    cmp eax, 1
    jl invalid

    mov eax, [range_end]
    cmp eax, 100
    jg invalid

    mov eax, [start]
    mov ebx, [range_end]
    cmp eax, ebx
    jg invalid

    ; ---- compute range sum ----
    mov ecx, [range_end]
    sub ecx, [start]
    inc ecx

    mov eax, [start]
    dec eax                   ; convert to 0-based index
    mov ebx, eax

    mov eax, 0
range_sum_loop:
    add eax, [arr + ebx*4]
    inc ebx
    loop range_sum_loop

    mov edx, eax
    mov eax, range_msg
    call print_string
    mov eax, edx
    call print_int
    call print_nl

    jmp end_program

invalid:
    mov eax, invalid_msg
    call print_string
    call print_nl

end_program:
    popa
    mov eax, 0
    leave
    ret
