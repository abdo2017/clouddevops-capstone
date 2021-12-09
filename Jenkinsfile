pipeline{
  
  environment{
    AWS_DEFAULT_REGION = "us-east-1"
  }
  
  agent any
  
  stages{
    
    stage("install deps") {
      steps {
        // install hadolint
        sh 'sudo wget -O /bin/hadolint https://github.com/hadolint/hadolint/releases/download/v1.16.3/hadolint-Linux-x86_64'
        sh 'sudo chmod +x /bin/hadolint'
        // install tidy html
        sh 'sudo apt install tidy --yes'
      }
    }
    stage('check for linting HTML and docker files') {
      steps {
          sh 'hadolint Dockerfile'
          sh 'tidy -q -e *.html'
      }
    }

    stage('build docker Image') {
      steps {
        sh 'sudo docker build -t clouddevops .'
      }
    }

    // stage("docker hub login") {
    //   steps {
    //     sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
    //   }
    // }

    stage('push docker Image to docker hub') {
      withDockerRegistry([url: "", credentialsId: "docker-cred"]) { 
        sh 'docker tag clouddevops abdoesam2011/clouddevops'
        sh 'docker push abdoesam2011/clouddevops'
      }
    }
    
    stage('Deploy image to EKS') {
      steps {
          withAWS(region:'us-east-1',credentials:'aws-cred') {
          sh "aws eks --region us-east-1 update-kubeconfig --name udacitycapstone"
          sh 'kubectl apply -f deployment/deploy.yml'
          sh 'kubectl apply -f deployment/load-balancer.yml'
          }
      }
    }



  }
}
