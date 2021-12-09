pipeline{
  
  environment{
    AWS_DEFAULT_REGION = "us-east-1"
    DOCKERHUB_CREDENTIALS = credentials("docker-cred")
  }
  
  agent any
  
  stages{

  stage('check for lingin HTML and docker files') {
      steps {
          sh 'hadolint Dockerfile'
          sh 'tidy -q -e *.html'
      }
    }

    stage('build docker Image') {
      steps {
        sh 'docker build -t clouddevops .'
      }
    }

    stage("docker hub login") {
      steps {
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
      }
    }

    stage('push docker Image to docker hub') {
      steps { 
        sh 'docker tag clouddevops abdoesam2011/clouddevops'
        sh 'docker push abdoesam2011/clouddevops'
      }
    }
    
    stage('Deploy image to EKS') {
      steps {
          withAWS(region:'us-east-2',credentials:'aws-static') {
          sh "aws eks --region us-east-2 update-kubeconfig --name udacitycapstone"
          
          sh 'kubectl apply -f website.yml'
          sh 'kubectl apply -f exposewebsite.yml'
          }
      }
    }
    
    post {
      always {
        sh 'docker logout'
      }  
    }
    
  }
}
