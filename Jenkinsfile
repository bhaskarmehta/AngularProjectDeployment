pipeline{
    agent any
    environment{
        dockerImage=''
        registry='bhasmeht/image5'
    }
    stages{
        stage('code clone'){
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/bhaskarmehta/AngularProjectDeployment.git']]])
            }
        }
        stage('build image'){
            steps{
                script{
                    dockerImage=docker.build registry
                }
            }
        }
        stage('push image to dockerhub'){
            steps{
                script{
                    docker.withRegistry('','dockerhub_id'){
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Deploy Helm App') {
            steps{
                sshagent(['kubernetes_id']) {
                    
                    sh "scp -r -o StrictHostKeyChecking=no helmdeployment ubuntu@44.203.53.179:~/"
                    script{
                        sh 'ssh ubuntu@44.203.53.179 wget https://get.helm.sh/helm-v3.9.3-linux-amd64.tar.gz'  
                        sh 'ssh ubuntu@44.203.53.179 tar xvf helm-v3.9.3-linux-amd64.tar.gz'
                        sh 'ssh ubuntu@44.203.53.179 sudo mv linux-amd64/helm /usr/local/bin'
                        sh 'ssh ubuntu@44.203.53.179 helm version'
                        sh "ssh ubuntu@44.203.53.179 helm install myhelm helmdeployment"
                    }
                }
            }
        }
      }
    }
}
