pipeline {
    agent any

    stages {
        stage('Build & Push Docker Image') {
            steps {
                script {
                    // Build and Push Docker image
                    withDockerRegistry(credentialsId: '61c758e2-9104-4d96-a534-08ba44934a2e', toolName: 'docker') {
                        sh "docker build -t nagaraj/currencyservice:latest ."
                        sh "docker push nagaraj/currencyservice:latest"
                    }
                }
            }
        }
    }
}
