; Gerador de Senhas Minimo - Assembly Windows
; Versao ultra-simplificada para garantir funcionamento

section .data
    msg db 'Gerador de Senhas Assembly', 0Ah, 'Senha: ', 0
    charset db 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789', 0
    
section .bss
    password resb 9     ; 8 caracteres + null

section .text
    global _start

_start:
    ; Gerar senha de 8 caracteres
    mov esi, password   ; destino
    mov ecx, 8          ; contador
    mov eax, 12345      ; seed simples
    
generate:
    ; Algoritmo simples: (seed * 7 + 13) mod 36
    mov edx, 7
    mul edx
    add eax, 13
    
    ; eax mod 36 (tamanho do charset)
    mov edx, 0
    mov ebx, 36
    div ebx             ; remainder em edx
    
    ; Pegar caractere do charset
    mov bl, [charset + edx]
    mov [esi], bl
    
    inc esi
    dec ecx
    jnz generate
    
    ; Null terminator
    mov byte [esi], 0
    
    ; Exibir usando int 21h (DOS)
    mov ah, 09h
    mov edx, msg
    int 21h
    
    ; Exibir senha
    mov ah, 09h
    mov edx, password
    int 21h
    
    ; Sair
    mov ah, 4Ch
    mov al, 0
    int 21h