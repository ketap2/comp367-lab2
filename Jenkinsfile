pipeline {
    agent any
    
    tools {
        maven 'Maven'
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build') {
            steps {
                bat 'mvn clean package'
            }
        }
        
        stage('Archive') {
            steps {
                archiveArtifacts artifacts: 'target/*.war', fingerprint: true
            }
        }
    }
    
    post {
        success {
            echo "Build completed successfully! Jenkins URL: ${env.JENKINS_URL}, Build ID: ${env.BUILD_ID}"
        }
        failure {
            echo "Build failed. Please check the logs."
        }
    }
}
