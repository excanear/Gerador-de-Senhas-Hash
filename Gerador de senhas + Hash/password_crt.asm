; Gerador de Senhas usando C Runtime
; Versao que deveria funcionar no Windows moderno

extern _printf
extern _scanf
extern _time
extern _srand
extern _rand
extern _exit

section .data
    welcome_fmt db 'Gerador de Senhas em Assembly', 10, 'Digite o comprimento (4-16): ', 0
    password_fmt db 10, 'Senha gerada: %s', 10, 0
    hash_fmt db 'Hash: %08X', 10, 0
    input_fmt db '%d', 0
    charset db 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()', 0
    charset_len equ $ - charset - 1

section .bss
    password resb 17
    length resd 1
    hash_value resd 1

section .text
    global _main

_main:
    push ebp
    mov ebp, esp
    
    ; Inicializar random seed
    push 0
    call _time
    add esp, 4
    push eax
    call _srand
    add esp, 4
    
    ; Exibir mensagem
    push welcome_fmt
    call _printf
    add esp, 4
    
    ; Ler comprimento
    push length
    push input_fmt
    call _scanf
    add esp, 8
    
    ; Verificar limites
    mov eax, [length]
    cmp eax, 4
    jl default_length
    cmp eax, 16
    jg default_length
    jmp generate_pass
    
default_length:
    mov dword [length], 8
    
generate_pass:
    ; Gerar senha
    mov ecx, [length]
    mov edi, password
    xor esi, esi
    
gen_loop:
    cmp esi, ecx
    jge gen_done
    
    ; Gerar numero aleatorio
    call _rand
    xor edx, edx
    mov ebx, charset_len
    div ebx
    
    ; Pegar caractere
    mov al, [charset + edx]
    mov [edi + esi], al
    
    inc esi
    jmp gen_loop
    
gen_done:
    mov byte [edi + esi], 0
    
    ; Calcular hash simples
    mov esi, password
    xor eax, eax
    
hash_loop:
    mov bl, [esi]
    test bl, bl
    jz hash_done
    
    mov edx, 31
    mul edx
    movzx ebx, bl
    add eax, ebx
    
    inc esi
    jmp hash_loop
    
hash_done:
    mov [hash_value], eax
    
    ; Exibir senha
    push password
    push password_fmt
    call _printf
    add esp, 8
    
    ; Exibir hash
    push dword [hash_value]
    push hash_fmt
    call _printf
    add esp, 8
    
    ; Sair
    push 0
    call _exit