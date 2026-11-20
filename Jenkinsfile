pipeline {
    agent any

    environment {
        IMAGE = "nodeapp"
    }

    stages {
        stage('Build image') {
            steps {
                sh 'docker build -t $IMAGE:$BUILD_NUMBER -t $IMAGE:latest .'
                sh 'docker images $IMAGE'
            }
        }

        stage('Run container') {
            steps {
                sh 'docker rm -f nodeapp || true'
                sh 'docker run -d --name nodeapp --restart unless-stopped -p 5000:5000 $IMAGE:latest'
                sh 'docker ps --filter name=nodeapp'
            }
        }
    }
}
