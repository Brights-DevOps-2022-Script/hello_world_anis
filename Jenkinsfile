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
 }
}