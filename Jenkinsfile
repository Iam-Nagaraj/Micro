pipeline {
    agent any
    stages {
        stage('Build and Push Docker Image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: '61c758e2-9104-4d96-a534-08ba44934a2e', toolName: 'docker') {
                        try {
                            sh 'docker build -t currencyservice .'
                            sh 'docker tag currencyservice vnraj685093/currencyservice:latest'
                            sh 'docker push vnraj685093/currencyservice:latest'
                        } catch (Exception err) {
                            echo "Error: ${err}"
                            error "Failed to build or push Docker image."
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
        failure {
            script {
                def logs = sh(script: 'docker logs $(docker ps -lq)', returnStdout: true)
                echo "Docker build logs:\n${logs}"
            }
            mail to: 'your-email@example.com',
                 subject: "Failed Pipeline: ${currentBuild.fullDisplayName}",
                 body: "Pipeline failed. Please check the logs: ${env.BUILD_URL}\n\nLogs:\n${logs}"
        }
    }
}
