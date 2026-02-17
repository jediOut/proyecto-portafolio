# Cloud Serverless API — AWS + Terraform + CI/CD

Proyecto de backend serverless desplegado en AWS utilizando principios DevOps e Infrastructure as Code.

##  Arquitectura

- AWS Lambda (Node.js)
- API Gateway (HTTP API)
- Terraform (Infrastructure as Code)
- GitHub Actions (CI/CD)
- Autenticación segura mediante OIDC (sin credenciales estáticas)
- Estado remoto de Terraform en S3

##  Características

- Infraestructura declarativa y reproducible
- Pipeline automatizado de build y despliegue
- Despliegues sin downtime mediante arquitectura serverless
- Control automático para evitar inconsistencias causadas por cambios manuales

##  Estructura del proyecto

-backend/ → Código API (NestJS / Node)
-infra/terraform/ → Infraestructura AWS (Terraform)
.github/workflows/ → Pipeline CI/CD


##  Flujo de despliegue

1. Push a la rama `main`
2. GitHub Actions construye el proyecto
3. Terraform aplica cambios de infraestructura
4. AWS actualiza automáticamente la Lambda

##  Objetivo

Practicar implementación de arquitectura cloud moderna siguiendo principios DevOps:

- Infrastructure as Code
- Automatización de despliegues
- Infraestructura reproducible
- Seguridad sin claves estáticas

---

