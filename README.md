# Portafolio de Noemi Capcha Advincula

Aplicación web Java para el curso **Proyecto de aplicación profesional**.

## Estructura solicitada en NetBeans

```text
Web Pages
├── META-INF
├── WEB-INF
├── assets
├── chatbot.jsp
├── dashboard.jsp
├── index.jsp
├── login.jsp
├── proyectos.jsp
├── registro.jsp
├── semanas.jsp
└── sobre-mi.jsp

Source Packages
├── controller
├── dao
├── model
└── util
```

## Requisitos
- JDK 17 o superior (recomendado JDK 17/21)
- Apache Tomcat 11
- Maven 3.9+
- NetBeans con soporte Maven Web

## Abrir en NetBeans
1. Descomprime el ZIP.
2. NetBeans → File → Open Project.
3. Selecciona la carpeta `portfolio-noemi-estructura`.
4. Configura Tomcat 11 como servidor.
5. Ejecuta el proyecto.

## Administrador inicial
- Usuario: `noemi`
- Contraseña: `Noemi2026!`

## Funciones
- Diseño responsive rosa inspirado en la referencia suministrada.
- Página de inicio, sobre mí, proyectos, semanas y chatbot.
- Registro e inicio de sesión.
- Dashboard protegido para administrador.
- Crear, editar y eliminar semanas.
- Subir, descargar y quitar archivos de cada semana.
- Los datos persisten en `~/.portfolio-noemi`.
