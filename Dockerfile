
FROM eclipse-temurin:21.0.7_6-jdk

WORKDIR /app

COPY ./pom.xml ./mvnw ./.mvn/ ./
RUN chmod +x mvnw && ./mvnw dependency:go-offline

COPY ./src ./src
COPY wait-for-mysql.sh ./wait-for-mysql.sh
RUN chmod +x ./wait-for-mysql.sh

RUN apt-get update && apt-get install -y default-mysql-client netcat

RUN ./mvnw clean package -DskipTests

ENTRYPOINT ["sh", "./wait-for-mysql.sh", "mysql_docker_db", "3306", "java", "-jar", "target/SpringDocker-0.0.1-SNAPSHOT.jar"]







