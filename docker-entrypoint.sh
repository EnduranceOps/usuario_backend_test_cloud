#!/bin/sh
set -e

# If RUN_MIGRATIONS is set to "true" run migrations & seed on container start
if [ "${RUN_MIGRATIONS:-false}" = "true" ]; then
  echo "Running prisma migrations..."
  npx prisma migrate deploy
  echo "Running prisma seed (if any)..."
  npx prisma db seed || true
fi

exec "$@"
