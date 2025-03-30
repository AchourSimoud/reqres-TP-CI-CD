pipeline {
    agent none
    stages {
        stage('Python Stage') {
            agent {
                docker {
                    image 'python:3.11'
                }
            }
            steps {
                script {
                    sh 'python --version'
                    sh 'echo "Running Python stage..."'
                }
            }
        }
        stage('Newman Stage') {
            agent {
                docker {
                    image 'postman/newman:alpine'
                }
            }
            steps {
                script {
                    sh 'newman --version'
                    sh 'echo "Running Newman stage..."'
                }
            }
        }
    }
}