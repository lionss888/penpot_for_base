# База — Terraform для облачного развёртывания
# Поддерживает: AWS, Yandex Cloud, или любой провайдер с Docker
# Пример: развёртывание на одном VPS с Docker

terraform {
  required_version = ">= 1.0"
  required_providers {
    # Раскомментировать нужный провайдер
    # aws = { source = "hashicorp/aws", version = "~> 5.0" }
    # yandex = { source = "yandex-cloud/yandex", version = "~> 0.100" }
  }
}

# Переменные
variable "baza_domain" {
  description = "Домен для База (например baza.company.com)"
  type        = string
  default     = "baza.example.com"
}

output "deploy_instructions" {
  value = <<-EOT
    Развёртывание База:
    1. cd ${path.module}/../docker
    2. cp .env.example .env
    3. Заполнить BAZA_PUBLIC_URI=https://${var.baza_domain}, BAZA_SECRET_KEY
    4. docker compose -p baza -f docker-compose.baza.yaml up -d
    5. Настроить Nginx/Traefik с SSL для ${var.baza_domain}
  EOT
}
