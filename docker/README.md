# Развёртывание База

## Требования

- Docker и Docker Compose
- 4+ vCPU, 8+ GB RAM (для production — см. [ПЛАН_РАЗВЁРТКИ_PENPOT_250_ПОЛЬЗОВАТЕЛЕЙ.md](../../ПЛАН_РАЗВЁРТКИ_PENPOT_250_ПОЛЬЗОВАТЕЛЕЙ.md))

## Быстрый старт (образы penpotapp)

```bash
cd ux/ui/penpot_for_base/docker
cp .env.example .env
docker compose -p baza -f docker-compose.baza.yaml up -d
```

## Скрыть «penpot» в Docker UI

```bash
./retag-as-baza.sh
# В .env: BAZA_IMAGE_PREFIX=baza
docker compose -p baza -f docker-compose.baza.yaml up -d --force-recreate
```

## Полный white label (База в UI)

Сборка frontend из форка с заменой текстов Penpot → База (~20 мин):

```bash
./build-baza-images.sh frontend
# В .env: BAZA_IMAGE_PREFIX=baza
docker compose -p baza -f docker-compose.baza.yaml up -d --force-recreate
```

При ошибке pnpm в Docker — попробуйте перезапустить Docker Desktop или собрать локально (pnpm, Clojure).

---

- **UI:** http://localhost:9011
- **API Gateway:** http://localhost:9012
- **MailCatcher (dev):** http://localhost:1081

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
