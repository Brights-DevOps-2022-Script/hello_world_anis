pipeline {
    agent {
        docker {
            // image 'cytopia/ansible'
            image 'devops2022.azurecr.io/alpine-simon'
            args '--entrypoint='
            args '--user root --privileges'
        }
    }
    environment {
    // ANSIBLE_KEY = credentials('ansible_VM')
    // ANSIBLE_HOST_KEY_CHECKING = 'False'
    KUBECONFIG = credentials('k8s_config')  
    ACR_CREDS = credentials('acr_creds')

    }
    stages {
       stage('build') {
            steps {
                sh "docker login -u $ACR_CREDS_USR -p $ACR_CREDS_PSW devops2022.azurecr.io"
                sh "docker build ."          
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
