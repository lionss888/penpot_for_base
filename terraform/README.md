# Terraform — облачное развёртывание База

## Использование

```bash
terraform init
terraform plan
terraform apply
```

## Варианты

- **main.tf** — базовая конфигурация, инструкции по развёртыванию
- **aws.tf.example** — пример для AWS EC2 (переименовать в aws.tf)
- **cloud-init.yaml.example** — cloud-init для автоматической установки Docker

## Рекомендуемые ресурсы

| Пользователей | EC2 instance | RAM |
|---------------|--------------|-----|
| до 50         | t3.medium    | 4 GB |
| до 250        | t3.large     | 8 GB |
| 250+          | t3.xlarge    | 16 GB |

## После развёртывания

1. Настроить DNS на IP инстанса
2. Установить SSL (Let's Encrypt): `certbot --nginx -d baza.example.com`
3. Настроить Nginx proxy к портам 9001 (frontend), 9002 (api)
