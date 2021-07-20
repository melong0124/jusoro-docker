node {
    def dockerImage
    def imageName = "api/cesnet"
    def registryName = "cesdocker.cesco.biz:12000"
    def registryUri = "http://" + registryName
    def imageTag
    def stackName = "cesnetapi"
    def remote1Uri = "cesnet1.cesco.biz:4243"
    def remote2Uri = "cesnet2.cesco.biz:4243"

    stage('Clone repository') {
        // Git 다운로드
        checkout scm
    }

    stage('Build image') {
        // 이미지 빌드
        dockerImage = docker.build(imageName)
    }

    stage('Push image') {
        // 이미지 업로드
        docker.withRegistry(registryUri, "cesdocker-hub") {
            def today = new Date()
            def yyMM = today.format("yyMM")
            imageTag = "${env.BUILD_NUMBER}.${yyMM}"
            
            dockerImage.push(imageTag)
            dockerImage.push("latest")
        }
    }

    stage('Deploy server 1') {
        // 배포
        // 원격지 서버 도커 로그인용
        docker.withServer(remote1Uri) {
            docker.withRegistry(registryUri, "cesdocker-hub") {
               sh "cat ~/.docker/config.json | grep ${registryName}"
            }
        }

        sh "docker -H ${remote1Uri} stack deploy -c ./ci/docker-compose.production.yaml ${stackName} --with-registry-auth"
    }

    stage('Deploy server 2') {
        // 배포
        // 원격지 서버 도커 로그인용
        docker.withServer(remote2Uri) {
            docker.withRegistry(registryUri, "cesdocker-hub") {
               sh "cat ~/.docker/config.json | grep ${registryName}"
            }
        }
        
        sh "docker -H ${remote2Uri} stack deploy -c ./ci/docker-compose.production.yaml ${stackName} --with-registry-auth"
    }

    stage('Delete image') {
        // 완료 이미지 삭제
        sh "docker image rm ${registryName}/${imageName}:latest"
        sh "docker image rm ${registryName}/${imageName}:${imageTag}"
    }
}