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
                stash includes: 'data/data2.csv', name: 'data_csv'
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
                     // Créer un répertoire pour les fichiers de test
                    sh 'mkdir -p $WORKSPACE/newman_data'
                    sh 'chmod -R 777 $WORKSPACE/newman_data'

                    // Déstacher les fichiers et corriger les permissions
                    unstash 'data_csv'
                    sh 'chmod -R 777 $WORKSPACE/data'
                    
                    // Vérifier les permissions et la présence des fichiers
                    sh 'ls -lR $WORKSPACE/data'

                    // Déplacer le fichier dans newman_data
                    sh 'mv $WORKSPACE/data/data2.csv $WORKSPACE/newman_data/data.csv'
                    sh 'chmod 777 $WORKSPACE/newman_data/data.csv'

                    // Vérifier après le déplacement
                    sh 'ls -lR $WORKSPACE/newman_data'

                    // Exécuter Newman
                    sh 'newman run collections/register_collection.json -e collections/testENV_environment.json -d $WORKSPACE/newman_data/data.csv'
                }
            }
        }
    }
}