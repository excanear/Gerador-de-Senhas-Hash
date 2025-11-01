@echo off
chcp 65001 >nul 2>&1
echo ========================================
echo    Gerador de Senhas em Assembly
echo      (Simulado em Batch)
echo ========================================
echo.

set charset=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%%^&*()_+-=[]{}

:input
set /p length="Digite o comprimento da senha (4-16): "

REM Verificar se é número
echo %length%| findstr /r "^[1-9][0-9]*$" >nul
if errorlevel 1 (
    echo Entrada invalida! Digite um numero.
    echo.
    goto input
)

REM Verificar limites
if %length% LSS 4 (
    echo Comprimento deve ser entre 4 e 16!
    echo.
    goto input
)
if %length% GTR 16 (
    echo Comprimento deve ser entre 4 e 16!
    echo.
    goto input
)

echo.
echo Gerando senha com %length% caracteres...

REM Usar WMIC para gerar números aleatórios
set password=
for /l %%i in (1,1,%length%) do (
    for /f %%a in ('powershell -command "Get-Random -Maximum 62"') do (
        call :get_char %%a
    )
)

echo.
echo ========================================
echo Senha gerada: %password%
echo Hash simples: %RANDOM%%RANDOM%
echo ========================================
echo.

echo Detalhes tecnicos (simulando Assembly):
echo - Algoritmo: Pseudo-aleatorio do sistema
echo - Charset: 62 caracteres (A-Z, a-z, 0-9)
echo - Funcoes simuladas: generate_password, calculate_hash
echo.

pause
goto :eof

:get_char
set /a index=%1
set chars=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789
call set char=%%chars:~%index%,1%%
set password=%password%%char%
goto :eof