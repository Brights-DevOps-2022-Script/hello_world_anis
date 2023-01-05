pipeline {
    agent {
        docker {
            image 'cytopia/ansible'
        }
    }
    environment {
    ANSIBLE_KEY = credentials('ansible_VM')
     ANSIBLE_HOST_KEY_CHECKING = 'False'
    }
    stages {
        stage('build') {
            steps {
                sh 'apk update'
                sh 'apk add --update --no-cache openssh sshpass'
                sh "ansible --version"
                sh "ansible-playbook --version"
                sh "ansible-galaxy --version"
                sh "ansible-playbook -i hostfile d-playbook.yml -e ansible_ssh_pass=$ANSIBLE_KEY_PSW"
                sh "ansible -i 20.218.243.211 -m shell -a 'docker --version'"
            }
        }
    }
}
