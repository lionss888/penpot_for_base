# Онбординг команды — База

Данный документ предназначен для новых участников проекта. Работа ведётся только с оболочкой «База».

## Что нужно знать

- **Продукт:** База — инструмент для дизайна и прототипирования
- **API:** REST API документирован в OpenAPI (`baza-api/openapi.yaml`)
- **Развёртывание:** Docker Compose, сервисы с префиксом `baza-*`

## Структура для разработки

```
penpot_for_base/
├── baza-api/       # API Gateway — основная точка разработки
├── docker/         # Развёртывание
├── assets/         # Логотипы, favicon
└── docs/           # Документация
```

## Работа с API

1. Изучить [baza-api/README.md](../baza-api/README.md)
2. Документация API: `GET /api/baza/v1/openapi.json`
3. Кастомные эндпоинты добавляются в `baza-api/src/`

## Локальный запуск

```bash
cd docker
cp .env.example .env
docker compose -p baza -f docker-compose.baza.yaml up -d
```

- UI: http://localhost:9001
- API: http://localhost:9002

## Переменные окружения

Используются только переменные с префиксом `BAZA_*`. См. `docker/.env.example`.
