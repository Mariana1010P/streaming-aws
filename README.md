# 📡 Plataforma de Streaming en AWS con Terraform

Este proyecto despliega una infraestructura básica en AWS que permite alojar un **servidor de streaming con NGINX y RTMP**, utilizando **Terraform** para su aprovisionamiento. Es ideal para entornos de desarrollo, pruebas o demostraciones.

---

## 🚀 Características

- Despliegue automático con Terraform.
- NGINX compilado con soporte para el módulo RTMP.
- Auto Scaling configurado con políticas de escalado y alarmas CloudWatch.
- Base de datos PostgreSQL en subred privada.
- Infraestructura organizada en subredes públicas y privadas.
- Seguridad gestionada mediante grupos de seguridad personalizados.

---

## 🧱 Infraestructura

- VPC con subredes públicas y privadas.
- EC2 con Launch Template personalizado.
- Auto Scaling Group con alarmas de CPU.
- RDS PostgreSQL con DB Subnet Group.
- Security Groups configurados para HTTP, SSH y RTMP.
- Balanceador de carga (opcional).

---

## ✅ Requisitos previos

Antes de iniciar, asegúrate de tener instalado:

- [Terraform](https://www.terraform.io/downloads)
- Una cuenta de AWS con permisos adecuados
- Llave SSH configurada para EC2 (`key_name`)
- AWS CLI configurado (`aws configure`)


---

## 🔐 Consideraciones de seguridad

- Asegúrese de restringir el acceso SSH a IP conocidas.
- No dejes credenciales en texto plano ni en el código fuente.
- Usa `terraform.tfvars` o variables de entorno para contraseñas sensibles.
- Habilita HTTPS y autenticación en producción.

---

## 🐛 Problemas conocidos

- El tipo de instancia debe ser compatible con la arquitectura de la AMI (ej: `t2.micro` con `x86_64`).
- La AMI debe usar BIOS tradicional para evitar conflictos con UEFI si la instancia no está basada en Nitro.
- Algunas configuraciones de seguridad pueden bloquear EC2 Instance Connect.

---

## 🛠️ Instrucciones de uso

```bash
# 1. Clonar el repositorio
git clone https://github.com/Mariana1010P/streaming-aws.git
cd streaming-terraform

# 2. Inicializar Terraform
terraform init

# 3. Revisar el plan de ejecución
terraform plan

# 4. Aplicar la infraestructura
terraform apply

# 5. (opcional) Destruir la infraestructura
terraform destroy

---
