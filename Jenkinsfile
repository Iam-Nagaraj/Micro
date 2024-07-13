pipeline {
    agent any
    stage('Build and Push Docker Image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: '61c758e2-9104-4d96-a534-08ba44934a2e', toolName: 'docker') {
                        sh "docker build -t boardgame ."
                        sh "docker tag boardgame vnraj685093/boardgame:latest"
                        sh "docker push vnraj685093/boardgame:latest"
                    }
                }
            }
        }
  }
