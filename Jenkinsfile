pipeline {
    agent any

    environment {
        registry = "public.ecr.aws/q8d8q2l8/my-docker-repo"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package -e -X'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Build Docker image') {
            steps {
                sh 'docker build -t myapp .'
            }
        }

        stage('Push to into ECR') {
            steps {
                sh 'aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/q8d8q2l8'
                sh 'docker tag myapp public.ecr.aws/q8d8q2l8/my-docker-repo:latest'
                sh 'docker push public.ecr.aws/q8d8q2l8/my-docker-repo:latest'
            }
        }

        stage('k8 deploy') {
            steps { 
                withKubeConfig(caCertificate: '', clusterName: '', contextName: '', credentialsId: 'k8s', namespace: '', restrictKubeConfigAccess: false, serverUrl: '') {
                    sh 'kubectl apply -f deployment.yaml'
                    sh 'kubectl apply -f service.yaml'
                }
            }
        }
                
    }       


    post {
        always {
            deleteDir()
        }
    }
}
