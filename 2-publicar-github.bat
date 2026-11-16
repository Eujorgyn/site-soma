@echo off
title Site Soma - Publicar no GitHub
cd /d "%~dp0"

if not exist "evidencias\get.png" (
  echo [ERRO] Falta o print evidencias\get.png
  pause
  exit /b 1
)
if not exist "evidencias\post.png" (
  echo [ERRO] Falta o print evidencias\post.png
  pause
  exit /b 1
)

where git >nul 2>nul
if errorlevel 1 (
  echo [ERRO] Git nao encontrado. Instale em https://git-scm.com e rode este arquivo de novo.
  pause
  exit /b 1
)

if not exist ".git" git init
git add .
git commit -m "Servidor Node.js com requisicoes GET e POST + evidencias"
git branch -M main

where gh >nul 2>nul
if not errorlevel 1 (
  gh auth status >nul 2>nul
  if not errorlevel 1 (
    echo === Criando o repositorio site-soma com o GitHub CLI ===
    gh repo create site-soma --public --source=. --remote=origin --push
    if not errorlevel 1 (
      for /f "delims=" %%u in ('gh repo view --json url -q .url') do set "REPO_URL=%%u"
      goto :fim
    )
  )
)

echo.
echo Crie um repositorio VAZIO em https://github.com/new
echo (nome sugerido: site-soma, publico, SEM README).
start "" https://github.com/new
echo.
set /p REPO_URL=Cole aqui o link do repositorio (ex: https://github.com/Eujorgyn/site-soma): 
git remote remove origin >nul 2>nul
git remote add origin %REPO_URL%.git
git push -u origin main
if errorlevel 1 (
  echo [ERRO] Falha no push. Confira o link e se voce esta logado no Git.
  pause
  exit /b 1
)

:fim
echo Link do repositorio no GitHub: %REPO_URL%> link-github.txt
echo.
echo ============================================================
echo  Pronto! Repositorio publicado: %REPO_URL%
echo  O arquivo link-github.txt foi criado nesta pasta.
echo  Anexe o link-github.txt na atividade do AVA.
echo ============================================================
start "" %REPO_URL%
pause
