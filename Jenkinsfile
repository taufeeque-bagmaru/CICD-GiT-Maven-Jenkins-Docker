pipeline {
    agent any

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

        stage('Deploy') {
            steps {
                sh 'docker run -d --name -p 8090:8080 mycontainer2 myapp'
            }
        }
    }

    post {
        always {
            deleteDir()
        }
    }
}
