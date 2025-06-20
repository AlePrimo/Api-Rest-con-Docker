
FROM eclipse-temurin:21.0.7_6-jdk

EXPOSE 8080
WORKDIR /app

# Copiar archivos esenciales
COPY ./pom.xml ./mvnw ./.mvn/ ./
RUN chmod +x mvnw
RUN ./mvnw dependency:go-offline

# Copiar código fuente y script de espera
COPY ./src ./src
COPY wait-for-mysql.sh /wait-for-mysql.sh
RUN chmod +x /wait-for-mysql.sh

# Instalar cliente de MySQL
RUN apt-get update && apt-get install -y default-mysql-client && apt-get clean

# Compilar la app
RUN ./mvnw clean package -DskipTests

# Ejecutar esperando a que MySQL esté listo
ENTRYPOINT ["/wait-for-mysql.sh", "mysql_docker_db", "3306", "dbuser", "dbpass1234", "dockerDB", "java", "-jar", "target/SpringDocker-0.0.1-SNAPSHOT.jar"]




