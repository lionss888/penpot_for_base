# Инструкция по развёртыванию База

## Требования

- Docker 24+ и Docker Compose v2
- 4+ vCPU, 8+ GB RAM (для production — см. план на 250 пользователей)

## Быстрый старт (разработка)

```bash
cd ux/ui/penpot_for_base/docker
cp .env.example .env
docker compose -p baza -f docker-compose.baza.yaml up -d
```

После запуска:
- **UI:** http://localhost:9001
- **API Gateway:** http://localhost:9002
- **MailCatcher:** http://localhost:1080 (просмотр писем)

## Production

### 1. Подготовка

- Сгенерировать `BAZA_SECRET_KEY`:
  ```bash
  python3 -c "import secrets; print(secrets.token_urlsafe(64))"
  ```
- Установить `BAZA_PUBLIC_URI=https://baza.company.com`
- Настроить SMTP (переменные в docker-compose или .env)

### 2. Безопасность

В `docker-compose.baza.yaml` изменить флаги:
- Убрать `disable-secure-session-cookies`
- Убрать `disable-email-verification`

### 3. Reverse Proxy (Nginx)

```nginx
server {
    listen 443 ssl;
    server_name baza.company.com;
    # SSL сертификаты

    location / {
        proxy_pass http://localhost:9001;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        client_max_body_size 30M;
    }

    location /api/baza/ {
        proxy_pass http://localhost:9002;
        proxy_set_header Host $host;
    }
}
```

### 4. Масштабирование

Для 250 пользователей — см. [ПЛАН_РАЗВЁРТКИ_PENPOT_250_ПОЛЬЗОВАТЕЛЕЙ.md](../../ПЛАН_РАЗВЁРТКИ_PENPOT_250_ПОЛЬЗОВАТЕЛЕЙ.md).

## Сервисы

| Сервис        | Порт | Описание              |
|---------------|------|-----------------------|
| baza-frontend | 9001 | SPA, UI               |
| baza-api      | 9002 | API Gateway           |
| baza-db       | —    | PostgreSQL (внутр.)   |
| baza-cache    | —    | Valkey (внутр.)       |
