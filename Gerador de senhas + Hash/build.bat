@echo off
REM ============================================================
REM build.bat - Build simples do gerador em Assembly (Win32)
REM Requer: NASM no PATH e estar num "x86 Native Tools Command
REM          Prompt for VS" (para ter o linker `link` + libs x86).
REM ============================================================
nasm -f win32 password_generator_win.asm -o password_generator_win.obj
if errorlevel 1 (echo [ERRO] Falha no NASM & exit /b 1)

REM Obs: o linker da Microsoft prefixa "_" ao nome passado em /entry,
REM entao o rotulo _start do .asm e alcancado com /entry:start.
link password_generator_win.obj kernel32.lib /subsystem:console /entry:start /out:password_generator_win.exe /nologo
if errorlevel 1 (echo [ERRO] Falha no link & exit /b 1)

echo [OK] Gerado password_generator_win.exe
