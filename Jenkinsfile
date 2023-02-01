pipeline {
    agent {
        docker {
            // image 'cytopia/ansible'
            image 'gcr.io/cloud-builders/kubectl'
        }
    }
    environment {
    // ANSIBLE_KEY = credentials('ansible_VM')
    // ANSIBLE_HOST_KEY_CHECKING = 'False'
        ACRCreds = credentials('acr_creds')
        KUBECONFIG = credentials('k8s_config')
    }
    stages {
       stage('build') {
            steps {
               sh 'docker build . '               
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
