###################################################
# Gradle Build
###################################################
FROM gradle:7.1.1-jdk11 AS build

# 빌드 준비
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN mvn dependency:go-offline

# Gradle 빌드
RUN gradle build --no-daemon 

###################################################
# Alpine Linux with OpenJDK JRE Spring boot
###################################################
FROM azul/zulu-openjdk-alpine:11-jre

# curl (헬스체크용) tzdata (시간대 맞추기용) 설치
RUN apk add --update curl tzdata bash

# 시간대 맞춰주기
RUN cp /usr/share/zoneinfo/Asia/Seoul /etc/localtime
RUN echo "Asia/Seoul" > /etc/timezone

# 빌드 스테이지에서 있던 jar 파일을 복사 한다.
COPY --from=build /home/gradle/src/build/libs/*.jar /app.jar

# Evnirment 설정
#ENV   PROFILE=develop \
#      RABBITMQURL=cesnet3.cesco.biz \
#      RABBITMQPORT=5672 \
#      DBNAME=CESCO
      

# 헬스 체크 설정
HEALTHCHECK \
 --interval=10s \
 --timeout=10s \
 --start-period=5s \
 --retries=10 \
 CMD curl --fail --silent localhost:8080/health | grep UP || exit 1

COPY ./ci/entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/entrypoint.sh / # backwards compat

ENTRYPOINT [ "bash", "entrypoint.sh" ]