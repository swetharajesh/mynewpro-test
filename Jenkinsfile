pipeline {
  environment {
    registry = "bellaryrajesh/testone"
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
    stage('Building image') {
      steps{
        script {
          docker.build registry + ":$BUILD_NUMBER"
     }
      }
    }
    stage ('Push image to Artifactory') { // take that image and push to artifactory
        steps {
            rtDockerPush(
                serverId: "jFrog-ar1",
                image: "168.62.183.49:8081/docker-vir/hello-world:latest",
                host: 'tcp://localhost:2375',
                targetRepo: 'local-repo', // where to copy to (from docker-virtual)
                                properties: 'project-name=docker1;status=stable'
              )
          }
        }
    }
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }

