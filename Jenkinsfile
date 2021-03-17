pipeline {
  environment {
    registry = "docker/testone"  
    registryCredential = 'dockerhub' 
    dockerImage = ''
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git branch: 'main', credentialsId: 'mycred', url: 'https://github.com/swetharajesh/mynewpro-test.git' 
      }
    }
    stage('Build Docker image') { 
        steps {
            echo 'Starting to build docker image'

            script {
                dockerImage = docker.build.registry

            }
        }
    }
  }
}
