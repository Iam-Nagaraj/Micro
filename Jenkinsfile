pipeline {
    agent any
    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }
        stage('Verify Checkout') {
            steps {
                sh 'ls -la'
                sh 'find . -name cartservice.csproj'
            }
        }
        stage('Build and Push Docker Image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: '61c758e2-9104-4d96-a534-08ba44934a2e', toolName: 'docker') {
                        try {
                            // Build Docker image
                            sh "docker build -t cartservice ."
                            // Tag Docker image
                            sh "docker tag cartservice vnraj685093/cartservice:latest"
                            // Push Docker image to registry
                            sh "docker push vnraj685093/cartservice:latest"
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
