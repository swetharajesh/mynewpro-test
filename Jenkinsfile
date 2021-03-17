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
                dockerImage = docker.build.registry + ":$BUILD_NUMBER"

            }
        }
    }
    stage('Deploy our image') { 
            steps { 
                script { 
                    docker.withRegistry( '', registryCredential ) { 
                        dockerImage.push()
						 }
                } 
            }
        } 
        stage('Cleaning up') { 
            steps { 
                sh "docker rmi $registry:$BUILD_NUMBER" 
            }
        } 
    }
}

