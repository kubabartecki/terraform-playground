FROM openjdk:21-jdk-slim

WORKDIR /app

COPY . ./

RUN apt-get update && apt-get install -y maven \
    && mvn clean package -DskipTests \
    && apt-get remove -y maven \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

ARG JAR_FILE=target/*.jar
RUN cp ${JAR_FILE} app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]
