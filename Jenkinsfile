pipeline {
    agent any

    stages {
        stage('Deploy To Kubernetes') {
            steps {
                withKubeCredentials(kubectlCredentials: [[caCertificate: '', clusterName: ' TSEKS-1', contextName: '', credentialsId: 'EKS-CRED', namespace: 'webapps', serverUrl: 'https://F0079E81620FD20043B85E4F1E4701BF.gr7.ap-south-1.eks.amazonaws.com']]) {
                    sh "kubectl apply -f deployment-service.yml"
                    sleep 60
                }
            }
        }
        
        stage('verify Deployment') {
            steps {
                withKubeCredentials(kubectlCredentials: [[caCertificate: '', clusterName: ' TSEKS-1', contextName: '', credentialsId: 'EKS-CRED', namespace: 'webapps', serverUrl: 'https://F0079E81620FD20043B85E4F1E4701BF.gr7.ap-south-1.eks.amazonaws.com']]) {
                    sh "kubectl get all -n webapps"
                }
            }
        }
    }
}
