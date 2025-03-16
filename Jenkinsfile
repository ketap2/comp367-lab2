pipeline {
    agent any
    
    tools {
        maven 'Maven'
    }
    
    environment {
        DOCKER_HUB_CREDS = credentials('docker-hub-credentials')
        DOCKER_IMAGE = "ketap/comp367-webapp"
        DOCKER_TAG = "${env.BUILD_NUMBER}"
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build Maven Project') {
            steps {
                sh 'mvn clean package'
            }
        }
        
        stage('Docker Login') {
            steps {
                sh 'echo $DOCKER_HUB_CREDS_PSW | docker login -u $DOCKER_HUB_CREDS_USR --password-stdin'
            }
        }
        
        stage('Docker Build') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE:$DOCKER_TAG -t $DOCKER_IMAGE:latest .'
            }
        }
        
        stage('Docker Push') {
            steps {
                sh 'docker push $DOCKER_IMAGE:$DOCKER_TAG'
                sh 'docker push $DOCKER_IMAGE:latest'
            }
        }
        
        stage('Deploy') {
            steps {
                sh 'docker stop comp367-webapp || true'
                sh 'docker rm comp367-webapp || true'
                sh 'docker run -d -p 8081:8080 --name comp367-webapp $DOCKER_IMAGE:latest'
            }
        }
    }
    
    post {
        always {
            sh 'docker logout'
            cleanWs()
        }
        success {
            echo "Pipeline completed successfully!"
            emailext (
                subject: "Build Success: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: "The build for ${env.JOB_NAME} #${env.BUILD_NUMBER} was successful. Check it out at ${env.BUILD_URL}",
                to: 'ketap712@gmail.com',
                from: 'jenkins@example.com'
            )
        }
        failure {
            echo "Pipeline failed. Please check the logs."
            emailext (
                subject: "Build Failed: ${env.JOB_NAME} #${env.BUILD_NUMBER}",
                body: "The build for ${env.JOB_NAME} #${env.BUILD_NUMBER} failed. Check the logs at ${env.BUILD_URL}",
                to: 'ketap712@gmail.com',
                from: 'jenkins@example.com'
            )
        }
    }
}