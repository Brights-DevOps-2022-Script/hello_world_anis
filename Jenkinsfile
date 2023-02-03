pipeline {
    agent any
    environment {
    KUBECONFIG = credentials('k8s_config')  
    ACR_CREDS = credentials('acr_creds')

    }
    stages {
        stage('build') {
            agent any
            steps {
                sh "docker build -t devops2022.azurecr.io/nginxanis:$GIT_COMMIT ."
            }
        }
        stage('push') {
            agent any
            steps {
                sh "docker login -u $ACR_CREDS_USR -p $ACR_CREDS_PSW devops2022.azurecr.io"
                sh "docker push devops2022.azurecr.io/nginxanis:$GIT_COMMIT"
            }
        }
        stage('remove from VM') {
            agent any
            steps {
                sh "docker rmi devops2022.azurecr.io/nginxanis:$GIT_COMMIT"
            }
        }
         stage('deploy') {
            agent {
                docker {
                    image 'devops2022.azurecr.io/timtest'
                    args '--entrypoint='
                 }
            }
             environment {
                KUBECONFIG = credentials('k8s_config') 
             }
            steps {
                
               sh "kubectl --kubeconfig=$KUBECONFIG apply -f nginxServiceDeploy.yaml -n namespaceanis"
               sh "kubectl set image -n namespaceanis deployment/nginx-deployment nginx=devops2022.azurecr.io/nginxanis:$GIT_COMMIT"
               
            }
        }
          stage('get LoadBalancer IP'){
            agent {
                docker {
                    image 'alpine/k8s:1.23.16'
                }
            }
            environment {
                KUBECONFIG = credentials('k8s_config') 
             }
            steps{
              script {
                    def output = sh(script: 'kubectl get service -n namespaceanis', returnStdout: true)
                    env.externalIp = output.split("\n")[1].split()[3].toString()
                    echo "External IP: ${externalIp}"
                }
                sh "curl -s ${env.externalIp}"
            }
   }
stage('commit an push to github') {
          agent{
                docker {
                    image 'bitnami/git'
                }
        }
        environment {
          GITCONFIG = credentials('2eb747c4-f19f-4601-ab83-359462e62482')
        }
           steps('Commit changes') {
                //sh 'rm -r test'
                sh 'pwd'
                sh 'git clone https://github.com/Brights-DevOps-2022-Script/hello_world_anis.git'
                sh'git branch -a'
                sh 'cd hello_world_anis'
                sh 'pwd'
                sh 'echo hallo >> test.txt'
                //sh 'git remote add origin https://github.com/Brights-DevOps-2022-Script/felix-agent'
                sh 'git add test.txt'
                sh 'git commit -m "Add test.txt file"'
                sh'git branch -a'
/*                 sh 'git branch -M main'
                sh 'git remote add origin https://github.com/fschultes/test.git' */
                //checkout scm
                //sh 'git checkout -b rubarb'
               // sh 'git push -u origin main'
            }
        }
    }
}
