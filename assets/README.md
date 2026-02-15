# Assets для База

- `logo.svg` — логотип (светлая тема)
- `logo-dark.svg` — логотип (тёмная тема)
- `favicon.svg` — иконка SVG
- `favicon.ico` — иконка ICO (генерируется)
- `favicon-32.png`, `favicon-16.png` — PNG-варианты
- `og-image.png` — Open Graph 1200x630 (генерируется)

## Генерация

```bash
npm install
npm run generate
```

## Volume-mount в Docker

В `docker/docker-compose.baza.yaml` настроен mount для penpotapp/frontend:

```yaml
- ../assets/logo.svg:/var/www/app/logo.svg:ro
- ../assets/favicon.ico:/var/www/app/favicon.ico:ro
```
