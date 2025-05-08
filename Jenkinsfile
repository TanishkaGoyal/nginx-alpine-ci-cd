pipeline {
    agent any

    environment {
        IMAGE_NAME = 'nginx-alpine-custom'
    }

    stages {
        stage('Clone Repository') {
            steps {
                checkout([$class: 'GitSCM',
                    branches: [[name: '*/main']],
                    userRemoteConfigs: [[
                        url: 'https://github.com/TanishkaGoyal/nginx-alpine-ci-cd.git',
                        credentialsId: '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i'  // Use the ID of your GitHub token here
                    ]]
                ])
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${IMAGE_NAME}")
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    dockerImage.run("-d -p 8080:80")
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up...'
            script {
                dockerImage.remove()
            }
        }
    }
}
