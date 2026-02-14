# Assets для База

- `logo.svg` — логотип (светлая тема)
- `logo-dark.svg` — логотип (тёмная тема)
- `favicon.svg` — иконка для вкладки

## Volume-mount в Docker

При использовании форка с известными путями в образе, раскомментировать в `docker-compose.baza.yaml`:

```yaml
volumes:
  - ../assets/logo.svg:/opt/penpot/frontend/static/logo.svg:ro
  - ../assets/favicon.svg:/opt/penpot/frontend/static/favicon.svg:ro
```

Для favicon.ico — сконвертировать favicon.svg через [favicon.io](https://favicon.io) или аналогичный инструмент.
