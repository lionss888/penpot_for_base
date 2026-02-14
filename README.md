# База — изолированное ядро продукта

Оболочка «baza» для поставки продукта заказчику. См. [ИЗОЛИРОВАННОЕ_ЯДРО.md](../ИЗОЛИРОВАННОЕ_ЯДРО.md).

## Структура

```
penpot_for_base/
├── docker/          # Docker-обёртка с именем baza
├── baza-api/        # API Gateway — обёртка над ядром
├── assets/          # Кастомные визуальные элементы
├── overrides/       # Переопределения (volume-mount)
├── i18n/            # Локализация
└── CHANGELOG.md
```

## Быстрый старт

```bash
cd docker
cp .env.example .env
# Отредактировать .env (BAZA_PUBLIC_URI, BAZA_SECRET_KEY)
docker compose -p baza -f docker-compose.baza.yaml up -d
```

## Документация

- [Инструкция по развёртыванию](docs/DEPLOYMENT.md)
- [Docker](docker/README.md)
- [API База](baza-api/README.md)
- [Онбординг команды](docs/ONBOARDING.md)
- [Стратегия репозитория](docs/REPOSITORY_STRATEGY.md)
