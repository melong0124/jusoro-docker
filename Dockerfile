FROM openjdk:8-jdk-alpine

LABEL maintainer="melong0124 <melong0124@me.com>"

RUN apk update && apk --no-cache add bash tzdata

# 변수 설정
ENV DW_FILE_NAME jusoro-2.0.0-linux64-internet.tar.gz
ENV APP_PATH /app/jusoro
ENV APP_BIN_PATH ${APP_PATH}/bin
ENV TZ=Asia/Seoul

# 폴더 생성
RUN mkdir -p /tmp && mkdir -p /app

RUN wget -O \
      /tmp/${DW_FILE_NAME} \
      "https://www.juso.go.kr/dn.do?fileName=${DW_FILE_NAME}&realFileName=${DW_FILE_NAME}&reqType=jusoro&gubun=jusoro&ctprvnCd=LINUX&stdde=LINUX64" \
      && tar zxvf /tmp/${DW_FILE_NAME} -C /app \
      && rm -r -f /tmp \
      && chmod -R 755 /app

# /app/datas : 주소 데이터
# /app/jusoro/server/logs : 로그
# /app/jusoro/server/etc : jetty 옵션 설정파일들
# /app/jusoro/server/resources : 로그 옵션 설정파일들
VOLUME ["/app/datas"]

# java 경로 변경
RUN sed -i 's/..\/..\/jdk1.8.0_102_linux64/\/usr\/lib\/jvm\/java-1.8-openjdk/' ${APP_BIN_PATH}/startup.sh

# solr root 실행 관련 로직 추가
RUN sed -i 's/start -p 8983 -m 4g/start -f -p 8983 -m 4g -force/' ${APP_BIN_PATH}/startup.sh

# 관리자 ip 설정
RUN sed -i 's/127.0.0.1/-.-.-.-/' ${APP_PATH}/server/etc/jetty.xml

# port 오픈
EXPOSE 8983

WORKDIR ${APP_BIN_PATH}

COPY docker-entrypoint.sh ./docker-entrypoint.sh

CMD ["bash", "./docker-entrypoint.sh"]