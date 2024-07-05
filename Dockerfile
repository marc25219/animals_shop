# Usa una imagen de Maven para compilar el proyecto
FROM maven:latest AS build

# Configura el directorio de trabajo
WORKDIR /app

# Copia el archivo pom.xml y otros archivos de configuración de Maven
COPY pom.xml ./
COPY src ./src

# Compila el proyecto
RUN mvn clean package -DskipTests

# Usa una imagen de OpenJDK para ejecutar el proyecto
FROM openjdk:21

# Configura el directorio de trabajo
WORKDIR /app

# Copia el archivo JAR desde la etapa de compilación
COPY --from=build /app/target/*.jar app.jar

# Expone el puerto en el que se ejecutará la aplicación
EXPOSE 8080

# Define el comando para ejecutar la aplicación
ENTRYPOINT ["java", "-jar", "app.jar"]