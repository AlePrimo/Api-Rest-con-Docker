
# IMAGEN MODELO
FROM eclipse-temurin:21.0.7_6-jdk

EXPOSE 8080
WORKDIR /app

# Copiar archivos esenciales
COPY ./pom.xml ./mvnw ./.mvn/ ./
RUN chmod +x mvnw
RUN ./mvnw dependency:go-offline

# Copiar código fuente y script de espera
COPY ./src ./src
COPY wait-for.sh /wait-for.sh
RUN chmod +x /wait-for.sh

# Compilar la app
RUN ./mvnw clean package -DskipTests

# Ejecutar esperando a que MySQL esté listo
ENTRYPOINT ["/wait-for.sh", "mysql_docker_db:3306", "--", "java", "-jar", "target/SpringDocker-0.0.1-SNAPSHOT.jar"]

