pipeline {  
/* Environment Variable declaration */
    environment {
    registry = "rdocker11/simplehello"
    registryCredential = 'dockerhub'
    dockerImage = ''
    PROJECT_ID = 'pure-vehicle-272119'
    CLUSTER_NAME = 'k8s'
    LOCATION = 'us-central1-a'
    CREDENTIALS_ID = 'My First Project'
    
  } 
  agent any
/* Tools used */
   tools { 
        maven 'maven3.6.3' 
        
    }
    /* Stages */
  stages {
      stage('Cloning Git') {
      steps {
        git 'https://github.com/alphacentrino/simplehello.git'
      }
    }
    /* Package Build */
    stage('Package Build'){
       steps{ 
           
        sh 'mvn clean package'
           
    }
    }
    
    stage('Building image') {
      steps{
        script {
          dockerImage=docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    
    stage('Deploy Image') {
  steps{    script {
      docker.withRegistry( '', registryCredential ) {
        dockerImage.push()
      }
    }
  }
}
stage('Remove Unused docker image') {
  steps{
    sh "docker rmi $registry:$BUILD_NUMBER"
  }
}

stage('Deploy to GKE') {
            steps{
                sh "sed -i 's/simplehello:latest/simplehello:${env.BUILD_ID}/g' deployment.yaml"
                sh "sed -i 's/web-deployment-buildid/web-deployment-${env.BUILD_ID}/g' deployment.yaml"
                step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'deployment.yaml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
            }
        }

  }
}