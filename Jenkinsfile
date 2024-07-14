pipeline {
    agent any
    stages {
        stage('Build and Push Docker Image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: '61c758e2-9104-4d96-a534-08ba44934a2e', toolName: 'docker') {
                        try {
                            sh "docker build -t recommendationservice ."
                            sh "docker tag recommendationservice vnraj685093/recommendationservice:latest"
                            sh "docker push vnraj685093/recommendationservice:latest"
                        } catch (Exception err) {
                            error "Failed to build or push Docker image: ${err}"
                        }
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
