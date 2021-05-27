FROM azul/zulu-openjdk-alpine:8

LABEL maintainer="melong0124"

RUN apk update && apk upgrade
RUN apk --no-cache add bash

# 변수 설정
ENV DW_FILE_NAME jusoro-2.0.0-linux64-internet.tar.gz
ENV APP_PATH /app/jusoro
ENV APP_BIN_PATH ${APP_PATH}/bin

# 폴더 생성
RUN mkdir -p /tmp
RUN mkdir -p /app

RUN wget -O \
      /tmp/${DW_FILE_NAME} \
      "https://www.juso.go.kr/dn.do?fileName=${DW_FILE_NAME}&realFileName=${DW_FILE_NAME}&reqType=jusoro&gubun=jusoro&ctprvnCd=LINUX&stdde=LINUX64"
RUN tar zxvf /tmp/${DW_FILE_NAME} -C /app
RUN chmod -R 755 /app

# /app/datas : 주소 데이터
# /app/jusoro/server/logs : 로그
# /app/jusoro/server/etc : jetty 옵션 설정파일들
# /app/jusoro/server/resources : 로그 옵션 설정파일들

# java 경로 변경
RUN sed -i 's/..\/..\/jdk1.8.0_102_linux64/\/usr\/lib\/jvm\/zulu8-ca/' ${APP_BIN_PATH}/startup.sh

# solr root 실행 관련 로직 추가
# -p 옵션 제거
RUN sed -i 's/start -p 8983 -m 4g/start -f -p 8983 -m 4g -force/' ${APP_BIN_PATH}/startup.sh

# 관리자 ip 설정
RUN sed -i 's/127.0.0.1/-.-.-.-/' ${APP_PATH}/server/etc/jetty.xml

# port 오픈
EXPOSE 8983

WORKDIR ${APP_BIN_PATH}

CMD ["./startup.sh"]