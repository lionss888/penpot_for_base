# White Label — замена визуала и текстов

## 1. Визуальные элементы (готово)

### Assets

| Файл | Назначение |
|------|------------|
| logo.svg | Логотип светлая тема |
| logo-dark.svg | Логотип тёмная тема |
| favicon.ico | Иконка вкладки (32x32, 16x16) |
| favicon-32.png, favicon-16.png | PNG-варианты |
| og-image.png | Open Graph 1200x630 для соцсетей |

### Генерация

```bash
cd assets
npm install
npm run generate
```

### Volume-mount в Docker

В `docker-compose.baza.yaml` настроен mount для penpotapp/frontend:

```yaml
- ../assets/logo.svg:/var/www/app/logo.svg:ro
- ../assets/favicon.ico:/var/www/app/favicon.ico:ro
```

Если образ использует другие пути — скорректировать в compose.

---

## 2. Замена текстов (требует форк)

Upstream не поддерживает i18n/white label из коробки. Для замены «Penpot» → «База» нужен форк.

### Ключевые места в upstream

| Файл | Что менять |
|------|------------|
| frontend/src/app/main/ui/icons.cljs | Лого в header |
| frontend/src/app/main/ui/auth.cljs | Экран входа/регистрации |
| frontend/src/app/main/ui/dashboard.cljs | Главный экран |
| frontend/src/app/main/ui/static.cljs | Meta-теги, favicon |
| frontend/src/app/main/ui/settings.cljs | Настройки |
| ds/foundations/assets/ | SVG-логотипы |

### Маппинг замен (i18n/baza-ru.json)

```json
{
  "app.name": "База",
  "app.slogan": "Дизайн и прототипирование",
  "auth.title": "Вход в База",
  "dashboard.title": "База",
  "footer.about": "О продукте",
  "footer.help": "Помощь"
}
```

### Процедура при форке

1. Форкнуть https://github.com/penpot/penpot
2. Заменить строки «Penpot» → «База» в указанных файлах
3. Подключить assets из `penpot_for_base/assets/`
4. Собрать образы с нейтральными именами (baza-frontend, baza-backend)
5. Обновить docker-compose для использования своих образов

---

## 3. Цвета (overrides/custom.scss)

Переменные для кастомизации:

```scss
:root {
  --baza-primary: #2563eb;
  --baza-accent: #3b82f6;
}
```

При форке — подключить через build или volume.
