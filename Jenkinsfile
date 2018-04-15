pipeline {
	agent none
	options {
		buildDiscarder(logRotator(numToKeepStr: '10'))
	}
	triggers {
		pollSCM 'H/3 * * * *'
	}
	stages {
		stage('Application Build and Test') {
			options {
		        timeout(time: 1, unit: 'HOURS')
			}
			agent 'osx' 
			steps {
				checkout scm
				sh "automation/processor/buildPackage.sh ${BUILD_NUMBER} ${BRANCH_NAME}"
			}
		}
	}
    post {
        success {
            echo 'I succeeeded!'
        }
        unstable {
            echo 'I am unstable :/'
			emailext (
				subject: "Jenkins Job Unstable : Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
				body: "${env.BUILD_URL}",
                attachLog: true,
				recipientProviders: [[$class: 'DevelopersRecipientProvider']]
			)
        }
        failure {
            echo 'I failed :('
			emailext (
				subject: "Jenkins Job Failed : Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
				body: "${env.BUILD_URL}",
                attachLog: true,
				recipientProviders: [[$class: 'DevelopersRecipientProvider']]
			)
        }
        changed {
            echo 'Things were different before...'
        }
    }	
}
