# baza-api — API Gateway

REST-обёртка над ядром продукта База. Скрывает внутреннюю структуру API, предоставляет нейтральные эндпоинты.

## Эндпоинты

| Метод | Путь | Описание |
|-------|------|----------|
| GET | /health | Health check |
| GET | /api/baza/v1 | Информация об API |
| * | /api/baza/v1/* | Прокси к ядру |

## Запуск

```bash
npm install
npm run build
BAZA_BACKEND_URL=http://localhost:9001 npm start
```

## Docker

Собирается как часть `docker-compose.baza.yaml`, сервис `baza-api`.

## Кастомные эндпоинты

Для добавления эндпоинтов под заказчика — расширить `src/index.ts` или добавить модули в `src/routes/`.
