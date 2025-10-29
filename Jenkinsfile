pipeline {
    agent any

    tools {
        jdk 'JDK21'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build & Test') {
            steps {
                bat 'mvn -B clean package'
            }
        }

        stage('Archive') {
            steps {
                archiveArtifacts artifacts: '**/target/*.jar', fingerprint: true
            }
        }

        stage('Run JAR') {
            steps {
                bat 'java -cp target/demo-maven-1.0-SNAPSHOT.jar com.example.App'
            }
        }
    }
}