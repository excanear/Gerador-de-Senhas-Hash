# Gerador de Senhas - PowerShell (Simulando Assembly)
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "   Gerador de Senhas em Assembly" -ForegroundColor Cyan
Write-Host "    (Simulado em PowerShell)" -ForegroundColor Cyan  
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Conjunto de caracteres
$charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_+-=[]{}|;:,.<>?"
$charset_len = $charset.Length

# Inicializar seed
$seed = [int](Get-Date).Ticks

# Funcao para gerar numero aleatorio
function Get-Random-LCG {
    $script:seed = (1664525 * $script:seed + 1013904223) -band 0xFFFFFFFF
    return $script:seed
}

# Loop principal
while ($true) {
    $length = Read-Host "Digite o comprimento da senha (4-32)"
    
    try {
        $password_length = [int]$length
        if ($password_length -lt 4 -or $password_length -gt 32) {
            Write-Host "Comprimento deve estar entre 4 e 32 caracteres!" -ForegroundColor Red
            Write-Host ""
            continue
        }
        break
    }
    catch {
        Write-Host "Entrada invalida! Digite um numero." -ForegroundColor Red
        Write-Host ""
    }
}

# Gerar senha
$password = ""
for ($i = 0; $i -lt $password_length; $i++) {
    $random_val = Get-Random-LCG
    $index = $random_val % $charset_len
    $password += $charset[$index]
}

# Calcular hash simples
$hash = 0
for ($i = 0; $i -lt $password.Length; $i++) {
    $char_val = [int][char]$password[$i]
    $hash = ($hash * 31 + $char_val) -band 0xFFFFFFFF
}

# Converter hash para hexadecimal
$hash_hex = "{0:X8}" -f $hash

# Exibir resultados
Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "Senha gerada: $password" -ForegroundColor Yellow
Write-Host "Hash da senha: $hash_hex" -ForegroundColor Magenta
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

Write-Host "Detalhes tecnicos (simulando Assembly):" -ForegroundColor Gray
Write-Host "- Algoritmo: Linear Congruential Generator" -ForegroundColor Gray
Write-Host "- Charset: $charset_len caracteres" -ForegroundColor Gray
Write-Host "- Hash algorithm: hash = (hash * 31 + char)" -ForegroundColor Gray
Write-Host ""

Write-Host "Componentes Assembly simulados:" -ForegroundColor DarkYellow
Write-Host "✓ init_random - Inicializacao do seed" -ForegroundColor DarkYellow
Write-Host "✓ get_random - Gerador LCG" -ForegroundColor DarkYellow
Write-Host "✓ generate_password - Geracao da senha" -ForegroundColor DarkYellow
Write-Host "✓ calculate_hash - Calculo do hash" -ForegroundColor DarkYellow
Write-Host "✓ int_to_hex - Conversao para hexadecimal" -ForegroundColor DarkYellow
Write-Host ""

Read-Host "Pressione Enter para sair"