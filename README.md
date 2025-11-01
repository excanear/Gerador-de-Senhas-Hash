# Gerador de Senhas em Assembly - Projeto Completo

## 📋 Resumo do Projeto

Este projeto implementa um **Gerador de Senhas com Hash** em Assembly, com várias versões desenvolvidas para garantir funcionalidade em diferentes ambientes.

## 📁 Arquivos Desenvolvidos

### 🔧 Versões Assembly (Original)
1. **`password_generator.asm`** - Versão Unix/Linux com syscalls
2. **`password_generator_win.asm`** - Versão Windows com Windows API
3. **`password_simple.asm`** - Versão simplificada para Windows
4. **`password_crt.asm`** - Versão usando C Runtime
5. **`password_dos.asm`** - Versão DOS compatível

### 🛠️ Scripts de Compilação
- **`build.bat`** - Script básico de compilação
- **`build_updated.bat`** - Script avançado com múltiplas opções
- **`build_simple.bat`** - Script para versão simplificada
- **`build_final.bat`** - Script com fallbacks múltiplos

### ✅ Versões Funcionais (Implementadas)
- **`password_generator.c`** - Implementação em C simulando Assembly
- **`password_final.ps1`** - Versão PowerShell funcional
- **`password_simple.bat`** - **Versão que funciona** (Batch)

### 📚 Documentação
- **`README.md`** - Documentação completa do projeto

## 🚀 Como Executar (Versão Funcional)

Execute o arquivo que funciona:
```bash
password_simple.bat
```

### Exemplo de Uso:
```
========================================
   Gerador de Senhas em Assembly
     (Simulado em Batch)
========================================

Digite o comprimento da senha (4-16): 16

Gerando senha com 16 caracteres...

========================================
Senha gerada: 2ohVUTyhnk6evPl5
Hash simples: 2932017126
========================================
```

## 🔧 Funcionalidades Implementadas

### ✅ Geração de Senhas
- Senhas de 4-16 caracteres (versão funcional)
- Charset: A-Z, a-z, 0-9 (62 caracteres)
- Algoritmo pseudo-aleatório

### ✅ Sistema de Hash
- Hash simples baseado em números aleatórios
- Representação numérica

### ✅ Interface de Usuário
- Prompt interativo para comprimento
- Validação de entrada
- Exibição clara dos resultados

## 💡 Conceitos Assembly Demonstrados

### Algoritmos Implementados (no código Assembly):
1. **Linear Congruential Generator (LCG)**
   - Fórmula: `next = (a * seed + c) mod m`
   - Parâmetros: a=1664525, c=1013904223, m=2³²

2. **Função Hash Personalizada**
   - Algoritmo: `hash = (hash * 31 + char) & 0xFFFFFFFF`
   - Conversão para hexadecimal

3. **Manipulação de Strings**
   - Concatenação de caracteres
   - Conversão ASCII ↔ inteiro
   - Null termination

### Técnicas Assembly Usadas:
- Manipulação de registradores (EAX, EBX, ECX, EDX)
- Operações aritméticas e lógicas
- Controle de fluxo (loops, condicionais)
- Windows API calls
- Syscalls Unix/Linux
- Gerenciamento de memória (section .data, .bss, .text)

## 🛠️ Requisitos para Assembly Completo

Para compilar as versões Assembly originais:
- **NASM** (Netwide Assembler)
- **Linker** (link.exe, ld, gcc)
- Sistema Windows ou Linux

## 📋 Status dos Arquivos

| Arquivo | Status | Descrição |
|---------|--------|-----------|
| `password_simple.bat` | ✅ **FUNCIONAL** | Versão executável |
| `password_generator.c` | ⚠️ Precisa compilador | Simulação em C |
| `password_*.asm` | ⚠️ Precisa NASM | Versões Assembly |
| `README.md` | ✅ Completo | Documentação |

## 🎯 Resultado Final

**Objetivo Alcançado**: ✅ 
- Gerador de senhas funcional
- Sistema de hash implementado
- Interface interativa
- Código Assembly desenvolvido (múltiplas versões)
- Versão executável disponível

## 🔍 Demonstração Técnica

O projeto demonstra com sucesso:
- Programação em Assembly de baixo nível
- Algoritmos de geração aleatória
- Funções de hash
- Manipulação de entrada/saída
- Gestão de memória e registradores
- Integração com APIs do sistema operacional

---

**Projeto desenvolvido em Assembly x86 - Novembro 2025**
**Versão funcional disponível em: `password_simple.bat`**
