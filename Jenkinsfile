#!/usr/bin/groovy

pipeline {
  agent { label 'LINUX' }
  //For maintaing logs and timeout
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
    timeout(time: 30, unit: 'MINUTES')
    disableConcurrentBuilds()
  }
//Paremets to be passed to the script
  parameters {
    string(name: 'IMAGE_ID', defaultValue: '')
    string(name: 'TLOCK_URL', defaultValue: 'https://containersectest.northamerica.cerner.net:8083')
  }

  stages {
    stage('Set User') {
      when {
        branch "main"
      }
      steps {
        script {
          wrap([$class: 'BuildUser']) {
            env.user_id = env.BUILD_USER_ID == null ? '' : env.BUILD_USER_ID
          }
        }
      }
    }
    stage('Download Image to Scan'){
      when {
        branch "main"
      }
      steps {
        script {
          if (params.IMAGE_ID == '' || user_id == null || user_id == ''){
            echo 'Skipping Job because user is not logged in or no image id was provided.'
            currentBuild.result = 'ABORTED'
          }
          docker.withRegistry('https://docker-production.cernerrepos.net') {
            image_to_scan = docker.image(params.IMAGE_ID)
            image_to_scan.pull()
          }
        }
      }
    }
    stage('Download and Run TwistCli'){
      when {
        branch "main"
      }
      steps {
        script {
          withCredentials([
            usernamePassword(credentialsId: 'svcEBIArtifactory')
          ]) {
            // Generate token to make other TLOCK requests.
            final TLOCK_RESPONSE = readJSON text: sh(returnStdout: true, script: 'curl -k -H "Content-Type: application/json" -X POST -d "{\\"username\\":\\"${TLOCK_USER}\\",\\"password\\":\\"${TLOCK_PASSWORD}\\"}" "${TLOCK_URL}/api/v1/authenticate"').trim()
            final String TLOCK_TKN = TLOCK_RESPONSE.token

            // Download TwistCLI
            sh "set +x; curl -k -L -H 'Authorization: Bearer ${TLOCK_URL}' -o twistcli '${TLOCK_URL}/api/v1/util/twistcli'"
            sh "set +x; chmod a+x ./twistcli"
            // Run TwistCLI for the given image
            sh "set +x; ./twistcli images scan --address ${TLOCK_URL} --token ${TLOCK_TKN} --details --publish docker-production.cernerrepos.net/${IMAGE_ID}"
          }
        }
      }
    }
  }
  post {
    always {
      script {
        cleanWs()
        // Remove un-used docker images to ensure agents do not run low on disk space
        sh 'docker image prune -f'
      }
    }
  }
}
