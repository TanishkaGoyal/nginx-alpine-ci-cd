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
                        credentialsId: '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i'  // GitHub token in Jenkins credentials
                    ]])
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo 'Building Docker image...'
                    dockerImage = docker.build("${IMAGE_NAME}")
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    echo 'Running Docker container...'
                    dockerImage.run("-d -p 8080:80")
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up Docker containers and images...'
            script {
                // Stopping and removing the container, then removing the image
                def container = docker.ps('-q --filter "ancestor=${IMAGE_NAME}"') // Get the container ID
                if (container) {
                    sh "docker stop ${container}"
                    sh "docker rm ${container}"
                }
                // Remove the image
                dockerImage.remove()
            }
        }
    }
}
