pipeline {
    agent any

    stages {
        stage('Build & Push Docker Image') {
            steps {
                script {
                    // Build and Push Docker image
                    withDockerRegistry(credentialsId: 'docker-cred', toolName: 'docker') {
                        sh "docker build -t nagaraj/currencyservice:latest ."
                        sh "docker push nagaraj/currencyservice:latest"
                    }
                }
            }
        }
    }
}
