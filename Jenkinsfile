pipeline {
    agent any

    stages {
        stage('Build & Tag Docker Image') {
            steps {
                script {
                    try {
                        dir('src') {
                            withDockerRegistry(credentialsId: '61c758e2-9104-4d96-a534-08ba44934a2e', toolName: 'docker') {
                                sh "docker build -t cartservice ."
                                sh "docker tag cartservice vnraj685093/cartservice:latest"
                                sh "docker push vnraj685093/cartservice:latest"
                            }
                        }
                    } catch (Exception err) {
                        error "Failed to build or push Docker image: ${err}"
                    }
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}
