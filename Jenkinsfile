pipeline {
  agent any
  stages {
  stage ('setup parameter') {
	steps {
		script{
				parameters {
    string(name: 'IMAGE_ID', defaultValue: '')
    string(name: 'TLOCK_URL', defaultValue: 'https://containersectest.northamerica.cerner.net:8083')
  }

  stages {
    stage('Set User') {
           steps {
        script {
          wrap([$class: 'BuildUser']) {
            env.user_id = env.BUILD_USER_ID == null ? '' : env.BUILD_USER_ID
          }
        }
      }
    }
    stage('Download Image to Scan'){
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
    stage('Download TwistCli'){
            steps {
        script {
          withCredentials([
            usernamePassword(credentialsId: 'svcEBIArtifactory')
          ]) {
            final TLOCK_RESPONSE = readJSON text: sh(returnStdout: true, script: 'curl -k -H "Content-Type: application/json" -X POST -d "{\\"username\\":\\"${TLOCK_USER}\\",\\"password\\":\\"${TLOCK_PASSWORD}\\"}" "${TLOCK_URL}/api/v1/authenticate"').trim()
            final String TLOCK_TKN = TLOCK_RESPONSE.token
			stage('Download TwistCli'){
				steps {
						script {
            sh "set +x; curl -k -L -H 'Authorization: Bearer ${TLOCK_URL}' -o twistcli '${TLOCK_URL}/api/v1/util/twistcli'"
            sh "set +x; chmod a+x ./twistcli"
			stage('Run TwistCLI'){
            steps {
        script {
            sh "set +x; ./twistcli images scan --address ${TLOCK_URL} --token ${TLOCK_TKN} --details --publish docker-production.cernerrepos.net/${IMAGE_ID}"
          }
        }
      }
    }
 }
--
