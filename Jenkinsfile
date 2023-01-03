pipeline {
    agent {
        docker {
            image 'cytopia/ansible'
        }
    }
    environment {
    ANSIBLE_KEY = credentials('209493f6-a90b-413d-aa6a-64511ca45eab')
    }
    stages {
        stage('build') {
            steps {
                sh 'echo building ...'
                sh "which ansible || true"
                sh "ansible --version"
                sh "ansible-playbook --version"
                sh "ansible-galaxy --version"
                sh "ansible-playbook -i list.host --private-key=$ANSIBLE_KEY playbook.yml"
            }
        }
    }
}
