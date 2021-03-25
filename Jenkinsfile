pipeline {
    agent any 
    environment {
                registry = "bellaryrajesh/testone"
                registryCredential = 'dockerhub'
        dockerImage = ''
    }
    
    stages {
        stage('Cloning Git') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'mycred', url: 'https://github.com/swetharajesh/mynewpro-test.git']]])       
            }
        }
    
    // Building Docker images
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry
        }
      }
    }
    
     // Uploading Docker images into Docker Hub
    stage('Upload Image') {
     steps{    
         script {
            docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
            }
        }
      }
    }  
    
     }
}
 stage ('Push image to Artifactory') { // take that image and push to artifactory
        steps {
            rtDockerPush(
                serverId: "jFrog-ar1",
                image: "skumartestdemo.jfrog.io/artifactory/docker-local/hello-world:latest",
                host: 'tcp://localhost:2375',
                targetRepo: 'local-repo', // where to copy to (from docker-virtual)
                // Attach custom properties to the published artifacts:
                properties: 'project-name=docker1;status=stable'
            )
        }
    }
