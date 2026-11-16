@echo off
title Site Soma - Servidor Node.js
cd /d "%~dp0"

where node >nul 2>nul
if errorlevel 1 (
  echo [ERRO] Node.js nao encontrado. Instale em https://nodejs.org e rode este arquivo de novo.
  pause
  exit /b 1
)

echo === Instalando dependencias (express) ===
call npm install
if errorlevel 1 (
  echo [ERRO] Falha no npm install.
  pause
  exit /b 1
)

echo.
echo === Abrindo o navegador nas paginas de teste ===
start "" cmd /c "timeout /t 3 >nul & start http://localhost:3001/ & start http://localhost:3001/teste"

echo.
echo ============================================================
echo  1) Aba http://localhost:3001/       -> tire o print do GET
echo     e salve como evidencias\get.png
echo  2) Aba http://localhost:3001/teste  -> clique "Enviar POST",
echo     tire o print e salve como evidencias\post.png
echo     (dica: Win + Shift + S para recortar a tela)
echo  3) Depois rode o arquivo 2-publicar-github.bat
echo  Para parar o servidor: Ctrl + C nesta janela.
echo ============================================================
echo.
node app.js
pause
