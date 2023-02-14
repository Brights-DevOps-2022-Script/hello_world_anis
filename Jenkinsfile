pipeline {
    agent any 
    stages {
        stage('BUILD') {
            steps {
                withDockerRegistry(credentialsId: 'acr_creds', url: 'https://devops2022.azurecr.io/v2/') {
                sh "docker build -t devops2022.azurecr.io/nginxanisbook:$GIT_COMMIT ."
                sh "docker push devops2022.azurecr.io/nginxanisbook:$GIT_COMMIT"
                sh "docker rmi devops2022.azurecr.io/nginxanisbook:$GIT_COMMIT"
                }
            }
        }
        stage('TEST') {
            steps {
                 script {
                    def imageTag = "nginxanisbook:$GIT_COMMIT"
                    def acrLoginServer = "devops2022.azurecr.io"
                    def imageExists = sh(script: "set +x curl -fL ${acrLoginServer}/v2/manifests/${imageTag}", returnStatus: true) == 0
                    if (!imageExists) {
                        error("The image ${imageTag} was not found in the registry ${acrLoginServer}")
                    }
                }
            }
        }
        stage('DEPLOY') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '2eb747c4-f19f-4601-ab83-359462e62482',  url: 'https://github.com/Brights-DevOps-2022-Script/argocd.git']]])
                withCredentials([usernamePassword(credentialsId: '2eb747c4-f19f-4601-ab83-359462e62482', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) 
                {
                    sh("git pull https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/Brights-DevOps-2022-Script/argocd.git HEAD:main")
                    sh("git checkout main")
                    sh("""
                      echo 'apiVersion: kustomization.config.k8s.io/v1beta1
                        kind: Kustomization
                        resources:
                        - nginx.yml
                        images:
                        - name: ANIS-NGINX
                        newName: devops2022.azurecr.io/nginxanis:${GIT_COMMIT}' > anis-argocd/kustomization.yaml
                    """)                    
                    sh("git add anis-argocd/kustomization.yaml")
                    sh("git commit -m 'kustom [skip ci]'")
                    sh("git push https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/Brights-DevOps-2022-Script/argocd.git HEAD:main")
                }
            }
        }
    }
}