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
                    sh 'mkdir -p $WORKSPACE/newman_data'
                    sh 'chmod -R 777 $WORKSPACE/newman_data'
                    unstash 'data_csv'
                    sh 'chmod -R 777 $WORKSPACE/data'

                    // Déplacer le fichier au bon endroit
                    sh 'mv $WORKSPACE/data/data.csv $WORKSPACE/newman_data/data.csv'

                    // Vérifier la présence du fichier
                    sh 'ls -lR $WORKSPACE/newman_data'

                    // Exécuter Newman avec le fichier CSV
                    sh 'newman run collections/register_collection.json -e collections/testENV_environment.json -d $WORKSPACE/newman_data/data.csv'   }
            }
        }
    }
}