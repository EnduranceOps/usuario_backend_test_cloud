#!/bin/bash

# Cambiar al directorio donde está el script
cd "$(dirname "$0")"

echo ""
echo "🚀 Inicializando backend..."
echo ""

echo "📦 Instalando dependencias..."
npm install
if [ $? -ne 0 ]; then
    echo "❌ Error en instalacion de dependencias"
    exit 1
fi

echo ""
echo "📊 Ejecutando migraciones..."
npx prisma migrate deploy
if [ $? -ne 0 ]; then
    echo "❌ Error en migraciones"
    exit 1
fi

echo ""
echo "🌱 Ejecutando seed..."
npx prisma db seed
if [ $? -ne 0 ]; then
    echo "❌ Error en seed"
    exit 1
fi

echo ""
echo "🔥 Iniciando servidor de desarrollo..."
npm run dev