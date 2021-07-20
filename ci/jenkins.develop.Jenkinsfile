node {
    def dockerImage
    def imageName = "develop/api/cesnet"
    def registryName = "cesdocker.cesco.biz:12000"
    def registryUri = "http://" + registryName
    def imageTag
    def stackName = "cesnetapi"
    def remoteUri = "cesnet3.cesco.biz:4243"

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

    stage('Deploy server') {
        // 배포
        // 원격지 서버 도커 로그인용
        docker.withServer(remoteUri) {
            docker.withRegistry(registryUri, "cesdocker-hub") {
               sh "cat ~/.docker/config.json | grep ${registryName}"
            }
        }

        sh "docker -H ${remoteUri} stack deploy -c ./ci/docker-compose.develop.yaml ${stackName} --with-registry-auth"
    }

    stage('Delete image') {
        // 완료 이미지 삭제
        sh "docker image rm ${registryName}/${imageName}:latest"
        sh "docker image rm ${registryName}/${imageName}:${imageTag}"
    }
}