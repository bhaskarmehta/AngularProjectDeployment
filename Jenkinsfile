pipeline{
    agent any
    environment{
        dockerImage=''
        registry='bhasmeht/angular-image'
    }
    stages{
        stage('code clone'){
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/bhaskarmehta/CI-CD-Pipeline.git']]])
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
        stage('Deploy App') {
            steps{
                sshagent(['kubernetes_id']) {
                    
                    sh "scp  -o StrictHostKeyChecking=no deploymentservice.yaml ubuntu@35.175.190.171:~/"
                    script{
                        try{
                            
                            sh "ssh ubuntu@35.175.190.171 kubectl apply -f ."
                        }
                        catch(error){
                           sh "ssh ubuntu@35.175.190.171 kubectl create -f ." 
                        }
                    }
                }
            }
        }
    }
}
