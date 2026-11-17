
# Paso 1: Compilar el proyecto con Maven y JDK 17
FROM maven:3.9-eclipse-temurin-17 AS build

WORKDIR /app
COPY . .

RUN mvn clean package -DskipTests

# Paso 2: Ejecutar con Tomcat 10.1
# Compatible con jakarta.servlet
FROM tomcat:10.1-jdk17-temurin

# Publicar la aplicación en la raíz
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
