# Gerador de Senhas Assembly - PowerShell
Clear-Host
Write-Host "========================================"
Write-Host "   Gerador de Senhas em Assembly"
Write-Host "    (Simulado em PowerShell)"  
Write-Host "========================================"
Write-Host ""

$charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()_+-=[]{}|;:,.<>?"
$charset_len = $charset.Length
$seed = [int](Get-Date).Ticks

function Get-Random-LCG {
    $script:seed = (1664525 * $script:seed + 1013904223) -band 0xFFFFFFFF
    return $script:seed
}

while ($true) {
    $length = Read-Host "Digite o comprimento da senha (4-32)"
    
    try {
        $password_length = [int]$length
        if ($password_length -lt 4 -or $password_length -gt 32) {
            Write-Host "Comprimento deve estar entre 4 e 32 caracteres!"
            Write-Host ""
            continue
        }
        break
    }
    catch {
        Write-Host "Entrada invalida! Digite um numero."
        Write-Host ""
    }
}

$password = ""
for ($i = 0; $i -lt $password_length; $i++) {
    $random_val = Get-Random-LCG
    $index = $random_val % $charset_len
    $password += $charset[$index]
}

$hash = 0
for ($i = 0; $i -lt $password.Length; $i++) {
    $char_val = [int][char]$password[$i]
    $hash = ($hash * 31 + $char_val) -band 0xFFFFFFFF
}

$hash_hex = "{0:X8}" -f $hash

Write-Host ""
Write-Host "========================================"
Write-Host "Senha gerada: $password"
Write-Host "Hash da senha: $hash_hex"
Write-Host "========================================"
Write-Host ""

Write-Host "Detalhes tecnicos:"
Write-Host "- Algoritmo: Linear Congruential Generator"
Write-Host "- Charset: $charset_len caracteres"
Write-Host "- Hash algorithm: hash = (hash * 31 + char)"
Write-Host ""

Write-Host "Componentes Assembly simulados:"
Write-Host "✓ init_random - Inicializacao do seed"
Write-Host "✓ get_random - Gerador LCG"
Write-Host "✓ generate_password - Geracao da senha"
Write-Host "✓ calculate_hash - Calculo do hash"
Write-Host "✓ int_to_hex - Conversao para hexadecimal"
Write-Host ""

$null = Read-Host "Pressione Enter para sair"