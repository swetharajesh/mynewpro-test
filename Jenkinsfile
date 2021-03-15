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
                image: "https://skumartestdemo.jfrog.io/docker-virtual/hello-world:latest",
                host: 'unix:///var/run/docker.sock',
                targetRepo: 'docker-local', // where to copy to (from docker-virtual)
                                properties: 'project-name=docker1;status=stable'
              )
          }
        }   
}
}
