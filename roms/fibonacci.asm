; Return the nth Fibonacci number 
; n is passed via r0
; Output value is returned via r0

section .text
    global _start

_start:
    mov r0, 0        ; First Fibonacci number
    mov r1, 1        ; Second Fibonacci number
    mov r2, 10       ; Number of Fibonacci numbers to generate
    mov r3, 0        ; Counter

print_fib:
    ; Print the current Fibonacci number
    push r0
    call print_number
    pop r0
    
    ; Calculate the next Fibonacci number
    add r0, r1       ; r0 = r0 + r1
    xchg r0, r1      ; Swap r0 and r1
    
    ; Increment counter
    inc r3
    cmp r3, r2
    jl print_fib
    
exit:
    mov eax, 60      ; syscall: exit
    xor edi, edi     ; status: 0
    syscall

print_number:
    ; Convert number in r0 to string and print
    push rbx
    push rcx
    push rdx
    push rsi
    mov rsi, buffer
    mov rcx, 10
next_digit:
    xor rdx, rdx
    div rcx
    add dl, '0'
    dec rsi
    mov [rsi], dl
    test rax, rax
    jnz next_digit
    
    mov rdx, buffer+10
    sub rdx, rsi
    mov rax, 1       ; syscall: write
    mov rdi, 1       ; stdout
    syscall
    
    mov rax, 1       ; syscall: write newline
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall
    
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    ret

section .bss
buffer resb 11

section .data
newline db 10


Halt
