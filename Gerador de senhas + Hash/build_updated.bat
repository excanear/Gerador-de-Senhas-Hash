@echo off
REM ============================================================
REM build_updated.bat - Build robusto do gerador em Assembly (Win32)
REM Localiza NASM e o ambiente do Visual Studio (x86) automaticamente.
REM ============================================================
setlocal enabledelayedexpansion

REM --- Localizar NASM ---
set "NASM="
where nasm >nul 2>&1 && set "NASM=nasm"
if not defined NASM if exist "%LOCALAPPDATA%\bin\NASM\nasm.exe" set "NASM=%LOCALAPPDATA%\bin\NASM\nasm.exe"
if not defined NASM if exist "%LOCALAPPDATA%\NASM\nasm.exe" set "NASM=%LOCALAPPDATA%\NASM\nasm.exe"
if not defined NASM (
    echo [ERRO] NASM nao encontrado. Instale de https://www.nasm.us e adicione ao PATH.
    exit /b 1
)

REM --- Garantir ambiente VS x86 (linker + libs) ---
where link >nul 2>&1
if not %errorlevel%==0 (
    set "VSWHERE=%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe"
    set "VSINST="
    if exist "!VSWHERE!" for /f "usebackq delims=" %%i in (`"!VSWHERE!" -latest -property installationPath`) do set "VSINST=%%i"
    if not defined VSINST (
        echo [ERRO] Visual Studio nao encontrado. Rode num "x86 Native Tools Command Prompt for VS".
        exit /b 1
    )
    call "!VSINST!\VC\Auxiliary\Build\vcvars32.bat" >nul 2>&1
)

echo [*] Montando (NASM win32)...
"!NASM!" -f win32 password_generator_win.asm -o password_generator_win.obj || (echo [ERRO] NASM & exit /b 1)

echo [*] Linkando (MSVC)...
link password_generator_win.obj kernel32.lib /subsystem:console /entry:start /out:password_generator_win.exe /nologo || (echo [ERRO] link & exit /b 1)

del password_generator_win.obj >nul 2>&1
echo [OK] Gerado password_generator_win.exe
endlocal
