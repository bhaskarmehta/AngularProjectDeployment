pipeline{
    agent any
    environment{
        dockerImage=''
        registry='bhasmeht/image1'
        registryCredential='dockerhub_id'
    }
    stages{
        stage('clone repo'){
            steps{
              checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/bhaskarmehta/test2.git']]])  
            }
        }
        stage('build image'){
            steps{
                script{
                    dockerImage = docker.build registry
                }
            }
        }
        stage('stop the running container'){
            steps{
                sh 'docker stop  mycontainer'
                sh 'docker rm mycontainer'
            }
        }
        stage('run image'){
            steps{
                script{
                    dockerImage.run("-p 82:80 --name mycontainer")
                }
            }
        }
        stage('push image to docker hub'){
            steps{
                script{
                    docker.withRegistry('',registryCredential){
                        dockerImage.push()
                    }
                }
            }
        }
    }
}
