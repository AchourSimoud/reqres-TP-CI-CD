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
                    sh 'pip3 install --upgrade -r requirements.txt --user'
                    sh 'echo "pip list'
                }
            }
        }
        stage('Newman Stage') {
            agent {
                docker {
                    image 'postman/newman:alpine'
                    args "--entrypoint=''"
                }
            }
            steps {
                script {
                    sh 'newman run collections/register_collection.json -e collections/testENV_environment.json -d data/data.csv'
                }
            }
        }
    }
}