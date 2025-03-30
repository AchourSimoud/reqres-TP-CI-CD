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
                    sh '''
                        python -m venv venv  # Création de l'environnement virtuel
                        source venv/bin/activate  # Activation du venv
                        pip install --upgrade pip  # Mise à jour de pip
                        pip install -r requirements.txt  # Installation des dépendances
                    '''
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