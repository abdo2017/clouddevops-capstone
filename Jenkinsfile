pipeline{

  environment{
    registry = "abdodesam2011/clouddevops"
    registryCredential = 'dockercred'
  }

  agent {
    docker { image 'node:14-alpine' }
  }

  stages{

  stage('check for lingin HTML and docker files') {
      steps {
          sh 'hadolint Dockerfile'
          sh 'tidy -q -e *.html'
      }
    }

    stage('build docker Image') {
      steps {
          sh 'docker build --tag=abdodesam2011/clouddevops .'
      }
    }

    stage('Upload docker Image') {
      steps {
        script {
          docker.withRegistry( '', registryCredential ) {
            sh 'docker push abdodesam2011/clouddevops'
          }
        }
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
  }

}
