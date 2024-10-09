FROM openjdk:21-slim-buster AS build

LABEL authors="andre"

# Traz todos os arquivos onde o Dockerfile está
COPY . .

# Transforma o mvnw em executável
RUN chmod 700 mvnw

RUN ./mvnw clean package


FROM openjdk:21-slim-buster

WORKDIR app

COPY --from=build target/*.jar app.jar

ENV SERVER_PORT=8081

EXPOSE 8081

ENTRYPOINT ["java", "-jar", "app.jar"]