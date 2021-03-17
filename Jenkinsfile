pipeline {
  environment {
    registry = "docker/testone"  ( Docker Repo name in Docker HUB)
    registryCredential = 'dockerhub' ( Docker Credentils which we added in Jenkins)
    dockerImage = ''
  }
  agent any
  stages {
    stage('Cloning Git') {
      steps {
        git branch: 'main', credentialsId: 'mycred', url: 'https://github.com/test/mynewpro-test.git' ( Git Project URL where Our Jenkinsfile Located)
      }
    }
  }
}
