# Helm Chart — База

## Установка

```bash
helm install baza ./helm/baza \
  --set baza.publicUri=https://baza.example.com \
  --set baza.secretKey=$(python3 -c "import secrets; print(secrets.token_urlsafe(64))")
```

## Зависимости

Chart ожидает:
- PostgreSQL (встроенный или внешний)
- Valkey/Redis (встроенный или внешний)

Для полного стека — добавить subchart или использовать Bitnami PostgreSQL.

## Масштабирование

```bash
helm upgrade baza ./helm/baza --set replicaCount.frontend=2 --set replicaCount.backend=2
```

## Ingress

По умолчанию включён. Настроить `values.yaml`:
- `ingress.hosts[].host` — домен
- `ingress.annotations` — cert-manager, nginx и т.д.
