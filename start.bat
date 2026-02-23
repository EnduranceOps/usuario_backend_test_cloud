@echo off
cd /d "%~dp0"
echo.
echo 🚀 Inicializando backend...
echo.

echo 📦 Instalando dependencias...
call npm install
if %errorlevel% neq 0 (
    echo Error en instalacion de dependencias
    exit /b %errorlevel%
)

echo.
echo 📊 Ejecutando migraciones...
call npx prisma migrate deploy
if %errorlevel% neq 0 (
    echo Error en migraciones
    exit /b %errorlevel%
)

echo.
echo 🌱 Ejecutando seed...
call npx prisma db seed
if %errorlevel% neq 0 (
    echo Error en seed
    exit /b %errorlevel%
)

echo.
echo 🔥 Iniciando servidor de desarrollo...
call npm run dev
