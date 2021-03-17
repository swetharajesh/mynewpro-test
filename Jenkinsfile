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
    stage('Deploy Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push("$BUILD_NUMBER")
             dockerImage.push('latest')
          }
          }
        } 
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $imagename:$BUILD_NUMBER"
         sh "docker rmi $imagename:latest"  
}
}
    }
  }
}
