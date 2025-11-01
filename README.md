# Gerador de Senhas em Assembly

Um gerador de senhas seguras implementado em Assembly x86, capaz de gerar senhas aleatórias e calcular seus hashes.

## 📋 Funcionalidades

- ✅ Geração de senhas aleatórias (4-32 caracteres)
- ✅ Conjunto de caracteres incluindo:
  - Letras maiúsculas (A-Z)
  - Letras minúsculas (a-z)
  - Números (0-9)
  - Símbolos especiais (!@#$%^&*()_+-=[]{}|;:,.<>?)
- ✅ Cálculo de hash da senha gerada
- ✅ Interface de console interativa
- ✅ Compatibilidade com Windows

## 🗂️ Estrutura do Projeto

```
Assembly Project/
├── password_generator.asm      # Versão Unix/Linux (syscalls)
├── password_generator_win.asm  # Versão Windows (Windows API)
├── build_updated.bat          # Script de compilação
├── build.bat                  # Script de compilação simples
└── README.md                  # Este arquivo
```

## 🛠️ Pré-requisitos

### Para Windows:

1. **NASM (Netwide Assembler)**
   - Baixe de: https://www.nasm.us/pub/nasm/releasebuilds/
   - Instale e adicione ao PATH do sistema

2. **Linker (uma das opções):**
   - Visual Studio Build Tools (recomendado)
   - MinGW-w64
   - MSYS2 com GCC

## 🚀 Como Compilar e Executar

### Método 1: Script Automático (Recomendado)
```bash
# Execute o script de build
build_updated.bat

# Escolha a versão:
# 1 - Versão Unix/Linux
# 2 - Versão Windows (recomendado para Windows)
```

### Método 2: Compilação Manual

**Para versão Windows:**
```bash
# Montar o código Assembly
nasm -f win32 password_generator_win.asm -o password_generator_win.obj

# Linkar (escolha uma opção):
# Com Microsoft Linker:
link password_generator_win.obj kernel32.lib /subsystem:console /entry:_start /out:password_generator_win.exe

# Com GCC:
gcc password_generator_win.obj -o password_generator_win.exe

# Executar
password_generator_win.exe
```

**Para versão Unix/Linux:**
```bash
# Montar o código Assembly
nasm -f elf64 password_generator.asm -o password_generator.o

# Linkar
ld password_generator.o -o password_generator

# Executar
./password_generator
```

## 💻 Como Usar

1. Execute o programa compilado
2. Digite o comprimento desejado da senha (entre 4 e 32 caracteres)
3. O programa irá:
   - Gerar uma senha aleatória
   - Calcular o hash da senha
   - Exibir ambos na tela

### Exemplo de Uso:
```
Gerador de Senhas em Assembly - Windows
Digite o comprimento da senha (4-32): 12

Senha gerada: K7m@9XzP4$nQ
Hash da senha: A3F7B2E1
```

## 🔧 Arquitetura Técnica

### Algoritmos Implementados:

1. **Gerador de Números Aleatórios**
   - Linear Congruential Generator (LCG)
   - Fórmula: `next = (a * seed + c) mod m`
   - Parâmetros: a=1664525, c=1013904223, m=2³²

2. **Função Hash**
   - Algoritmo personalizado baseado em multiplicação
   - Fórmula: `hash = (hash * 31 + char) & 0xFFFFFFFF`
   - Saída: 8 caracteres hexadecimais

3. **Seed de Aleatoriedade**
   - Unix: Timestamp atual (sys_time)
   - Windows: GetTickCount() API

### Funções Principais:

- `generate_password`: Gera senha aleatória
- `calculate_hash`: Calcula hash da senha
- `get_random`: Gera número pseudo-aleatório
- `int_to_hex`: Converte inteiro para hexadecimal
- `string_to_int`: Converte entrada do usuário para inteiro

## 🔒 Considerações de Segurança

⚠️ **Importante**: Este projeto é para fins educacionais!

- O gerador de números aleatórios (LCG) não é criptograficamente seguro
- Para uso em produção, utilize geradores criptográficos como:
  - `/dev/urandom` (Linux)
  - `CryptGenRandom` (Windows)
  - Bibliotecas criptográficas dedicadas

## 📚 Conceitos Assembly Demonstrados

- Manipulação de registradores
- Operações aritméticas e lógicas
- Controle de fluxo (loops, condicionais)
- Chamadas de sistema (syscalls)
- Windows API calls
- Manipulação de strings
- Conversão de tipos de dados
- Gerenciamento de memória

## 🐛 Solução de Problemas

### Erro: "NASM não encontrado"
- Instale o NASM e adicione ao PATH
- Reinicie o prompt de comando

### Erro: "Nenhum linker encontrado"
- Instale Visual Studio Build Tools
- Ou instale MinGW-w64/MSYS2

### Erro de execução
- Certifique-se de usar a versão correta (Windows vs Unix)
- Verifique se todas as dependências estão instaladas

## 🎓 Fins Educacionais

Este projeto demonstra:
- Programação em Assembly de baixo nível
- Interfaces com sistema operacional
- Algoritmos de geração de números aleatórios
- Funções de hash simples
- Manipulação de entrada/saída

## 📄 Licença

Este projeto é de domínio público para fins educacionais.

---

**Desenvolvido em Assembly x86 - Novembro 2025**
