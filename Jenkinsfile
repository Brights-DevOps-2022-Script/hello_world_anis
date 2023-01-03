pipeline {
    agent {
        docker {
            image 'cytopia/ansible'
        }
    }
    environment {
    ANSIBLE_KEY = credentials('209493f6-a90b-413d-aa6a-64511ca45eab')
    ANSIBLE_HOST_KEY_CHECKING = "False"
    }
    stages {
        stage('build') {
            steps {
                sh 'echo building ...'
                sh "which ansible || true"
                sh "ansible --version"
                sh "ansible-playbook --version"
                sh "ansible-playbook -i hostfile --private-key=$ANSIBLE_KEY playbook.yml"
            }
        }
    }
}
