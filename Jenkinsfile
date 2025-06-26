pipeline {
  agent any
  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub')
    SONARQUBE = 'SonarQubeServer'
    SLACK_CHANNEL = '#devops-alerts'
  }

  stages {
    stage('Checkout') {
      steps {
        git 'https://github.com/your-org/your-repo.git'
      }
    }

    stage('Code Quality') {
      steps {
        withSonarQubeEnv('SonarQubeServer') {
          sh './gradlew sonarqube'
        }
      }
    }

    stage('Build Docker Image') {
      steps {
        sh 'docker build -t myapp:${BUILD_NUMBER} .'
        sh 'docker tag myapp:${BUILD_NUMBER} <your-dockerhub>/myapp:${BUILD_NUMBER}'
        sh 'docker push <your-dockerhub>/myapp:${BUILD_NUMBER}'
      }
    }

    stage('Deploy to Kubernetes') {
      steps {
        sh 'kubectl apply -f k8s/deployment.yaml'
        sh 'kubectl apply -f k8s/service.yaml'
      }
    }
  }

  post {
    success {
      slackSend(channel: "${SLACK_CHANNEL}", message: "✅ Build ${BUILD_NUMBER} succeeded")
    }
    failure {
      slackSend(channel: "${SLACK_CHANNEL}", message: "❌ Build ${BUILD_NUMBER} failed")
    }
  }
}
