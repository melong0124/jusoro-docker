# 주소검색솔루션 for Docker

## 개요

비공식 [주소검색솔루션](https://www.juso.go.kr/addrlink/jusoSearchSolutionIntroduce.do) Dockerized 입니다.

## 사용법

1. docker build

```bash
docker build --pull --rm -f "Dockerfile" -t jusorodockerize:latest "."
```

2. docker run

```bash
docker run -d -p 80:8983 --name jusorodockerize jusorodockerize:latest
```

3. option file 변경

    - 주요 파일 경로
      - /app/datas : 주소 데이터
      - /app/jusoro/server/logs : 로그
      - /app/jusoro/server/etc : jetty 옵션 설정파일들
      - /app/jusoro/server/resources : 로그 옵션 설정파일들

## 기타

개발자센터 : https://www.juso.go.kr/addrlink/jusoSearchSolutionIntroduce.do