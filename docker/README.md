# Развёртывание База

## Требования

- Docker и Docker Compose
- 4+ vCPU, 8+ GB RAM (для production — см. [ПЛАН_РАЗВЁРТКИ_PENPOT_250_ПОЛЬЗОВАТЕЛЕЙ.md](../../ПЛАН_РАЗВЁРТКИ_PENPOT_250_ПОЛЬЗОВАТЕЛЕЙ.md))

## Быстрый старт

```bash
cd ux/ui/penpot_for_base/docker
cp .env.example .env
# Отредактировать .env: BAZA_PUBLIC_URI, BAZA_SECRET_KEY
docker compose -p baza -f docker-compose.baza.yaml up -d
```

- **UI:** http://localhost:9001
- **API Gateway:** http://localhost:9002
- **MailCatcher (dev):** http://localhost:1080

## Production

1. Установить `BAZA_PUBLIC_URI=https://baza.company.com`
2. Сгенерировать `BAZA_SECRET_KEY`
3. Настроить реальный SMTP (переменные `PENPOT_SMTP_*` в compose)
4. Убрать флаги `disable-secure-session-cookies` и `disable-email-verification`
5. Настроить reverse proxy (Nginx/Traefik) с HTTPS
6. Настроить S3 для assets (см. [ПЛАН_РАЗВЁРТКИ](../../ПЛАН_РАЗВЁРТКИ_PENPOT_250_ПОЛЬЗОВАТЕЛЕЙ.md))

## Сервисы

| Сервис        | Порт | Назначение                    |
|---------------|------|------------------------------|
| baza-frontend | 9001 | SPA, статика                 |
| baza-api      | 9002 | API Gateway (REST)           |
| baza-mailcatch| 1080 | SMTP (только dev)            |
