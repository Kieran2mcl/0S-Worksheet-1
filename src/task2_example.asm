%include "asm_io.inc"

segment .data
    x dd 20
    y dd 0

segment .text
global asm_main

asm_main:
    enter 0,0
    pusha

    mov eax, [x]
    cmp eax, 3
    jle else_part     ; if x <= 3 → go to else

    ; THEN part
    mov dword [y], 10
    jmp endif

else_part:
    mov dword [y], 20

endif:
    mov eax, [y]
    call print_int
    call print_nl

    popa
    mov eax, 0
    leave
    ret
