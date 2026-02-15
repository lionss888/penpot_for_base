#!/usr/bin/env bash
# Быстрое переименование образов penpotapp → baza (скрывает "penpot" в Docker UI)
# UI-тексты останутся Penpot — для полной замены нужна сборка: ./build-baza-images.sh frontend

set -e
echo ">> Переименование образов penpotapp → baza..."

docker tag penpotapp/frontend:latest baza/frontend:latest 2>/dev/null || true
docker tag penpotapp/backend:latest baza/backend:latest 2>/dev/null || true
docker tag penpotapp/exporter:latest baza/exporter:latest 2>/dev/null || true

echo ">> Готово. Установите в .env: BAZA_IMAGE_PREFIX=baza"
echo ">> Затем: docker compose -p baza -f docker-compose.baza.yaml up -d --force-recreate"
