pipeline {
    agent any

    stages {
        stage('Build & Tag Docker Image') {
            steps {
                script {
                    dir('src') {
                        withDockerRegistry(credentialsId: '61c758e2-9104-4d96-a534-08ba44934a2e', toolName: 'docker') {
                            sh "docker build -t nagaraj/cartservice:latest ."
                            sh "docker push nagaraj/cartservice:latest "
                        }
                    }
                }
            }
        }
    }
}
