; Gerador de Senhas em Assembly - Versão Windows
; Compatível com Windows API

extern _ExitProcess@4
extern _GetStdHandle@4
extern _WriteConsoleA@20
extern _ReadConsoleA@20
extern _GetTickCount@0

section .data
    welcome_msg db 'Gerador de Senhas em Assembly - Windows', 0Dh, 0Ah, 0
    welcome_len equ $ - welcome_msg - 1
    
    length_prompt db 'Digite o comprimento da senha (4-32): ', 0
    length_prompt_len equ $ - length_prompt - 1
    
    password_msg db 0Dh, 0Ah, 'Senha gerada: ', 0
    password_msg_len equ $ - password_msg - 1
    
    hash_msg db 0Dh, 0Ah, 'Hash da senha: ', 0
    hash_msg_len equ $ - hash_msg - 1
    
    newline db 0Dh, 0Ah, 0
    newline_len equ $ - newline - 1
    
    ; Conjunto de caracteres para gerar a senha
    charset db 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_+-=[]{}|;:,.<>?', 0
    charset_len equ $ - charset - 1
    
    STD_OUTPUT_HANDLE equ -11
    STD_INPUT_HANDLE equ -10

section .bss
    hStdOut resd 1
    hStdIn resd 1
    password resb 33           ; Buffer para senha
    input_buffer resb 10       ; Buffer para entrada
    hash_buffer resb 17        ; Buffer para hash (16 caracteres + null)
    password_length resb 1
    seed resd 1
    bytes_written resd 1
    bytes_read resd 1

section .text
    global _start

_start:
    ; Obter handles do console
    push STD_OUTPUT_HANDLE
    call _GetStdHandle@4
    mov [hStdOut], eax
    
    push STD_INPUT_HANDLE
    call _GetStdHandle@4
    mov [hStdIn], eax
    
    ; Inicializar seed
    call _GetTickCount@0
    mov [seed], eax
    
    ; Exibir mensagem de boas-vindas
    push 0
    push bytes_written
    push welcome_len
    push welcome_msg
    push dword [hStdOut]
    call _WriteConsoleA@20
    
main_loop:
    ; Solicitar comprimento da senha
    push 0
    push bytes_written
    push length_prompt_len
    push length_prompt
    push dword [hStdOut]
    call _WriteConsoleA@20
    
    ; Ler entrada do usuário
    push 0
    push bytes_read
    push 10
    push input_buffer
    push dword [hStdIn]
    call _ReadConsoleA@20
    
    ; Converter entrada para inteiro
    call string_to_int
    
    ; Verificar se o comprimento é válido (4-32)
    cmp al, 4
    jl main_loop
    cmp al, 32
    jg main_loop
    
    mov [password_length], al
    
    ; Gerar senha
    call generate_password
    
    ; Exibir senha
    push 0
    push bytes_written
    push password_msg_len
    push password_msg
    push dword [hStdOut]
    call _WriteConsoleA@20
    
    ; Calcular comprimento da senha para exibição
    mov esi, password
    call string_length
    
    push 0
    push bytes_written
    push eax               ; comprimento da senha
    push password
    push dword [hStdOut]
    call _WriteConsoleA@20
    
    ; Calcular e exibir hash
    call calculate_hash
    
    push 0
    push bytes_written
    push hash_msg_len
    push hash_msg
    push dword [hStdOut]
    call _WriteConsoleA@20
    
    push 0
    push bytes_written
    push 16                ; hash sempre tem 16 caracteres
    push hash_buffer
    push dword [hStdOut]
    call _WriteConsoleA@20
    
    push 0
    push bytes_written
    push newline_len
    push newline
    push dword [hStdOut]
    call _WriteConsoleA@20
    
    ; Sair do programa
    push 0
    call _ExitProcess@4

; Função para gerar número pseudo-aleatório
get_random:
    ; LCG: next = (a * seed + c) mod m
    mov eax, [seed]
    mov edx, 1664525
    mul edx
    add eax, 1013904223
    mov [seed], eax
    ret

; Função para gerar senha aleatória
generate_password:
    pushad
    
    xor ecx, ecx               ; contador
    movzx ebx, byte [password_length]
    mov edi, password
    
generate_loop:
    cmp ecx, ebx
    jge generate_done
    
    ; Gerar número aleatório
    call get_random
    
    ; Obter índice no charset
    xor edx, edx
    mov ebx, charset_len
    div ebx                    ; edx = eax % charset_len
    
    ; Obter caractere do charset
    mov al, [charset + edx]
    mov [edi + ecx], al
    
    inc ecx
    movzx ebx, byte [password_length]  ; Recarregar ebx
    jmp generate_loop
    
generate_done:
    mov byte [edi + ecx], 0    ; Null terminator
    
    popad
    ret

; Função para calcular hash simples da senha
calculate_hash:
    pushad
    
    mov esi, password
    mov edi, hash_buffer
    xor eax, eax               ; hash = 0
    xor ecx, ecx               ; contador
    
hash_loop:
    mov bl, [esi + ecx]
    test bl, bl
    jz hash_done
    
    ; Hash simples: hash = (hash * 31 + char) & 0xFFFFFFFF
    mov edx, 31
    mul edx
    movzx ebx, bl
    add eax, ebx
    
    inc ecx
    jmp hash_loop
    
hash_done:
    ; Converter hash para string hexadecimal
    call int_to_hex
    
    popad
    ret

; Função para converter inteiro para hexadecimal
int_to_hex:
    push ebx
    push ecx
    push edx
    
    mov ebx, eax               ; valor a converter
    mov ecx, 8                 ; 8 dígitos hex para 32 bits
    mov edi, hash_buffer
    add edi, 7                 ; Começar do final
    
hex_loop:
    mov eax, ebx
    and eax, 0xF               ; Pegar os 4 bits menos significativos
    
    ; Converter dígito para caractere hex
    cmp al, 9
    jle hex_digit
    add al, 'A' - 10
    jmp hex_store
hex_digit:
    add al, '0'
hex_store:
    mov [edi], al
    dec edi
    shr ebx, 4                 ; Próximos 4 bits
    
    dec ecx
    jnz hex_loop
    
    mov byte [hash_buffer + 8], 0  ; Null terminator após 8 caracteres
    
    pop edx
    pop ecx
    pop ebx
    ret

; Função para calcular comprimento da string
string_length:
    push esi
    xor eax, eax
    
length_loop:
    cmp byte [esi + eax], 0
    je length_done
    inc eax
    jmp length_loop
    
length_done:
    pop esi
    ret

; Função para converter string para inteiro
string_to_int:
    push esi
    push ebx
    push ecx
    
    mov esi, input_buffer
    xor eax, eax               ; resultado
    xor ebx, ebx               ; dígito atual
    
convert_loop:
    mov bl, [esi]
    
    ; Verificar se é dígito
    cmp bl, '0'
    jl convert_done
    cmp bl, '9'
    jg convert_done
    
    ; Converter caractere para dígito
    sub bl, '0'
    
    ; resultado = resultado * 10 + dígito
    mov ecx, 10
    mul ecx
    add eax, ebx
    
    inc esi
    jmp convert_loop
    
convert_done:
    pop ecx
    pop ebx
    pop esi
    ret