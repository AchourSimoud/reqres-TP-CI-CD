pipeline {
    agent none
    stages {
        stage('Python Stage') {
            agent {
            docker {
                image 'python:3.11'
                args '--user root'
            }
            }
            steps {
            script {
                sh ' python -m venv venv '
                sh '. venv/bin/activate' 
                sh 'pip install --upgrade pip' 
                sh 'pip install -r requirements.txt'  
                sh 'python3 scripts/Dataprep.py'
                stash includes: 'data/data.csv', name: 'data_csv'
                //sh 'mv data/data.csv $WORKSPACE/data.csv'

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
                    unstash 'data_csv'
                    // Exécuter Newman
                    sh 'newman run collections/register_collection.json -e collections/testENV_environment.json -d data/data.csv'
                }
            }
        }
    }
}