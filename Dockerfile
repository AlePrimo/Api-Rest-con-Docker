
# IMAGEN MODELO
FROM eclipse-temurin:21.0.7_6-jdk

EXPOSE 8080

WORKDIR /app

# Copiar solo lo necesario para descargar dependencias
COPY ./pom.xml ./mvnw ./.mvn/ ./

# Dar permisos de ejecución
RUN chmod +x mvnw

# Descargar dependencias
RUN ./mvnw dependency:go-offline

# Copiar el código fuente
COPY ./src ./src

# Compilar la app
RUN ./mvnw clean package -DskipTests

# Ejecutar
ENTRYPOINT ["java", "-jar", "target/SpringDocker-0.0.1-SNAPSHOT.jar"]
