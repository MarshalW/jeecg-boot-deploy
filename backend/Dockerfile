# FROM openjdk:17-alpine
FROM anapsix/alpine-java:8_server-jre_unlimited
RUN addgroup -S spring && adduser -S spring -G spring

# RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN mkdir -p /jeecg-boot
RUN chmod 777 /jeecg-boot
WORKDIR /jeecg-boot

RUN mkdir -p /logs
RUN chmod 777 /logs


USER spring:spring

EXPOSE 8080

ARG JAR_FILE=dist/jeecg-boot-module-system-*.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","app.jar"]