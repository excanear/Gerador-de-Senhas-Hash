#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

// Simulação do comportamento Assembly
// Gerador de Senhas em C (simulando Assembly)

char charset[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_+-=[]{}|;:,.<>?";
char password[33];
char hash_buffer[17];
int seed_value;
int password_length;

// Simula a função get_random do Assembly
int get_random() {
    // LCG: next = (a * seed + c) mod m
    // Usando a=1664525, c=1013904223, m=2^32
    seed_value = (1664525 * seed_value + 1013904223);
    return seed_value;
}

// Simula a função generate_password do Assembly
void generate_password() {
    int charset_len = strlen(charset);
    
    for (int i = 0; i < password_length; i++) {
        int random_val = get_random();
        int index = abs(random_val) % charset_len;
        password[i] = charset[index];
    }
    password[password_length] = '\0';
}

// Simula a função calculate_hash do Assembly
unsigned int calculate_hash() {
    unsigned int hash = 0;
    
    for (int i = 0; password[i] != '\0'; i++) {
        // Hash simples: hash = (hash * 31 + char) & 0xFFFFFFFF
        hash = hash * 31 + (unsigned char)password[i];
    }
    
    return hash;
}

// Converte hash para hexadecimal (simula int_to_hex)
void int_to_hex(unsigned int value) {
    sprintf(hash_buffer, "%08X", value);
}

int main() {
    // Inicializar seed (simula init_random)
    seed_value = (int)time(NULL);
    
    printf("========================================\n");
    printf("   Gerador de Senhas em Assembly\n");
    printf("     (Versao Simulada em C)\n");  
    printf("========================================\n\n");
    
    while (1) {
        printf("Digite o comprimento da senha (4-32): ");
        
        if (scanf("%d", &password_length) != 1) {
            // Limpar buffer de entrada em caso de erro
            while (getchar() != '\n');
            printf("Entrada invalida! Tente novamente.\n\n");
            continue;
        }
        
        // Verificar limites
        if (password_length < 4 || password_length > 32) {
            printf("Comprimento deve estar entre 4 e 32 caracteres!\n\n");
            continue;
        }
        
        break;
    }
    
    // Gerar senha
    generate_password();
    
    // Calcular hash
    unsigned int hash_value = calculate_hash();
    int_to_hex(hash_value);
    
    // Exibir resultados
    printf("\n========================================\n");
    printf("Senha gerada: %s\n", password);
    printf("Hash da senha: %s\n", hash_buffer);
    printf("========================================\n");
    
    printf("\nDetalhes tecnicos (simulando Assembly):\n");
    printf("- Algoritmo: Linear Congruential Generator\n");
    printf("- Charset: %d caracteres\n", (int)strlen(charset));
    printf("- Seed inicial: %d\n", (int)time(NULL));
    printf("- Hash algorithm: hash = (hash * 31 + char)\n");
    
    printf("\nPressione Enter para sair...");
    getchar(); // Consumir o \n restante
    getchar(); // Aguardar Enter
    
    return 0;
}