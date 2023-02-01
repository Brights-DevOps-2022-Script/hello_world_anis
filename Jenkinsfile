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
//        stage('build') {
//            steps {
//                sh 'apk update'
//                sh 'apk add --update --no-cache openssh sshpass'
//                sh "ansible --version"
//                sh "ansible-playbook --version"
//              sh "ansible-galaxy --version"
//               // sh "ansible-playbook -i hostfile playbook.yml -e ansible_ssh_pass=$ANSIBLE_KEY_PSW"
//                sh "ansible-playbook -i hostfile jenkins-playbook.yml -e ansible_ssh_pass=$ANSIBLE_KEY_PSW"
//            }
//        }
        stage('Testing kubectl') {
            steps {
                script {
                    sh 'kubectl apply -f nginx-namespace.yaml'
                }
            }
          }
    }
}
