FROM maven:3.8.5-openjdk-11 AS maven_build
COPY pom.xml  /tmp/
COPY src /tmp/src/
WORKDIR /tmp/
RUN mvn clean package

FROM eclipse-temurin:11
LABEL maintainer="UserName"
EXPOSE 8080
RUN useradd -u 1002 appuser
COPY --from=maven_build  /tmp/target/hello-world-0.1.0.jar /data/hello-world-0.1.0.jar
USER appuser
CMD ["java", "-jar", "/data/hello-world-0.1.0.jar"] 
