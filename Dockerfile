
# PASO 1: Compilar el proyecto Java con Maven y JDK 17

FROM maven:3.8.6-eclipse-temurin-17 AS build

WORKDIR /app

COPY . .

RUN mvn clean package -DskipTests

# PASO 2: Ejecutar la aplicacion con Apache Tomcat 11

FROM tomcat:11.0-jdk17-temurin

COPY --from=build /app/target/portfolio-noemi.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
