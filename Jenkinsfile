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
    stage('Build image') { // build and tag docker image
        steps {
            echo 'Starting to build docker image'

            script {
                def dockerfile = 'Dockerfile'
                def customImage = docker.build('*.*.*.*:8081/docker-virtual/hello-world:latest', "-f ${dockerfile} .")

            }
        }
    }
  }
}
