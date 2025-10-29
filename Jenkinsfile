pipeline {
    agent any

    tools {
        jdk 'JDK21'
    }

    environment {
        DOCKER_HUB_REPO = 'varshitha1105/pra'   // your Docker Hub repo name
        IMAGE_TAG = 'latest'
    }

    stages {
        stage('Checkout') {
            steps {
                echo '📥 Checking out source code...'
                checkout scm
            }
        }

        stage('Build & Test') {
            steps {
                echo '⚙️ Building and testing project with Maven...'
                bat 'mvn -B clean package'
            }
        }

        stage('Archive') {
            steps {
                echo '📦 Archiving build artifacts...'
                archiveArtifacts artifacts: '**/target/*.jar', fingerprint: true
            }
        }

        stage('Run JAR') {
            steps {
                echo '▶️ Running the built JAR file...'
                bat 'java -cp target/demo-maven-1.0-SNAPSHOT.jar com.example.App'
            }
        }

        // 🐳 NEW STAGE: Build Docker Image
        stage('Build Docker Image') {
            steps {
                echo '🐳 Building Docker image...'
                bat "docker build -t ${DOCKER_HUB_REPO}:${IMAGE_TAG} ."
            }
        }

        // 🚀 NEW STAGE: Push Docker Image to Docker Hub
        stage('Push to Docker Hub') {
            steps {
                echo '🚀 Pushing Docker image to Docker Hub...'
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials',
                                                 usernameVariable: 'DOCKER_USER',
                                                 passwordVariable: 'DOCKER_PASS')]) {
                    bat """
                        echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin
                        docker push ${DOCKER_HUB_REPO}:${IMAGE_TAG}
                    """
                }
            }
        }
    }

    post {
        success {
            echo '✅ CI/CD Pipeline completed successfully — Image pushed to Docker Hub!'
        }
        failure {
            echo '❌ Build or deployment failed.'
        }
    }
}
