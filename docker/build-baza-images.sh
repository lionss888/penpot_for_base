#!/usr/bin/env bash
# Сборка образов База из форка (с заменой Penpot → База в UI)
# Запуск: ./build-baza-images.sh [frontend|all]
# Время: frontend ~15–30 мин, all ~45–60 мин

set -e
cd "$(dirname "$0")/.."

MODE=${1:-frontend}

echo ">> Сборка образов База (режим: $MODE)"
echo ">> Требуется: penpotapp/devenv:latest (docker pull penpotapp/devenv:latest)"
echo ""

build_frontend() {
    echo ">> 1/2 Сборка frontend bundle (ClojureScript, ~15–25 мин)..."
    ./manage.sh build-frontend-bundle

    echo ">> 2/2 Сборка Docker-образа baza/frontend..."
    rsync -avr --delete ./bundles/frontend/ ./docker/images/bundle-frontend/
    pushd ./docker/images >/dev/null
    docker build \
        -t baza/frontend:latest \
        --build-arg BUNDLE_PATH="./bundle-frontend/" \
        -f Dockerfile.frontend .
    popd >/dev/null
    echo ">> Готово: baza/frontend:latest"
}

build_all() {
    build_frontend
    echo ">> Сборка backend..."
    ./manage.sh build-backend-bundle
    rsync -avr --delete ./bundles/backend/ ./docker/images/bundle-backend/
    pushd ./docker/images >/dev/null
    docker build -t baza/backend:latest \
        --build-arg BUNDLE_PATH="./bundle-backend/" \
        -f Dockerfile.backend .
    popd >/dev/null

    echo ">> Сборка exporter..."
    ./manage.sh build-exporter-bundle
    rsync -avr --delete ./bundles/exporter/ ./docker/images/bundle-exporter/
    pushd ./docker/images >/dev/null
    docker build -t baza/exporter:latest \
        --build-arg BUNDLE_PATH="./bundle-exporter/" \
        -f Dockerfile.exporter .
    popd >/dev/null

    echo ">> Готово: baza/frontend, baza/backend, baza/exporter"
}

case "$MODE" in
    frontend) build_frontend ;;
    all)     build_all ;;
    *)       echo "Использование: $0 [frontend|all]"; exit 1 ;;
esac
