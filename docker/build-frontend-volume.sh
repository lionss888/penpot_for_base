#!/usr/bin/env bash
# Обход ошибки pnpm -116 на macOS: копируем проект в volume, строим там
set -e
cd "$(dirname "$0")/.."
VOLUME_NAME="penpotdev_build_copy"
echo ">> Копирование проекта в Docker volume (обход bind mount)..."
docker volume create ${VOLUME_NAME} 2>/dev/null || true
HOST_UID=$(id -u)
docker run --rm -e HOST_UID=${HOST_UID} -v "$(pwd)":/src -v ${VOLUME_NAME}:/build alpine sh -c "rm -rf /build/* /build/.[!.]* 2>/dev/null; cp -a /src/. /build/; chown -R \${HOST_UID}:0 /build"
echo ">> Запуск сборки в volume..."
docker run -t --rm \
  --mount source=${VOLUME_NAME},type=volume,target=/home/penpot/penpot \
  --mount source=penpotdev_user_data,type=volume,target=/home/penpot/ \
  -e EXTERNAL_UID=$(id -u) \
  -e BUILD_WASM=${BUILD_WASM:-true} \
  -w /home/penpot/penpot/frontend \
  penpotapp/devenv:latest sudo -EH -u penpot ./scripts/build "$(git describe --tags --match '*.*.*' 2>/dev/null || echo develop)"
echo ">> Копирование результата обратно..."
mkdir -p frontend/target
docker run --rm -v ${VOLUME_NAME}:/build -v "$(pwd)":/out alpine sh -c "rm -rf /out/frontend/target/dist; cp -a /build/frontend/target/dist /out/frontend/target/"
echo ">> Готово. Соберите образ: cd docker && ./build-baza-images.sh frontend"
