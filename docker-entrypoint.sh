# app-data 폴더 구조 생성
echo 'create app-data folder -'
mkdir -p /app/datas
mkdir -p /app/jusoro/server/logs

# tomcat 실행
echo 'start -'
sh ./startup.sh