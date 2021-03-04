pipeline {
    environment {
    registary= "docker_hub_account/bellaryrajesh / testone
    registaryCredential = 'bellaryrajesh'
    }
    
    agent any
    stages {
        stage('Git Clone') {
            steps {
                git branch: 'main', credentialsId: 'mycred', url: 'https://github.com/swetharajesh/mynewpro-test.git'
            }
        }
    }
    stage('Building image') {
      steps{
        script {
          docker.build registry + ":$BUILD_NUMBER"
    post { 
        always { 
            echo 'I will always say Hello again!'
        }
    }
}
