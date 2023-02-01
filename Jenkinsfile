pipeline {
/*     agent {
        docker {
            image 'devops2022.azurecr.io/alpine-simon'
            args '--entrypoint='
            args '--user root --privileged'
        }
    }
    environment {
    // ANSIBLE_KEY = credentials('ansible_VM')
    // ANSIBLE_HOST_KEY_CHECKING = 'False'
    KUBECONFIG = credentials('k8s_config')  
    ACR_CREDS = credentials('acr_creds')
    dockerimagename = "devops2022.azurecr.io/alpine-simon"
    dockerImage = ""

    } */
    environment {
    dockerimagename = "devops2022.azurecr.io/alpine-test"
    dockerImage = ""
  }

  agent any
    stages {
       stage('build') {
            steps {
                dockerImage = docker.build dockerimagename
                sh 'echo docekerImage'
       
           }
        }
        stage('deploy') {
            steps {
                script {
                    sh 'kubectl apply -f nginx-namespace.yaml'
                }
            }
          }
    }
}
