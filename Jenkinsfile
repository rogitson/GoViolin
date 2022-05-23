pipeline{
    
    agent any

    environment {
        dockerImg = ''
        reg = "rogitson/goviolin"
        regID = 'dockerhub'
    }

    stages {
        stage('build') {
        steps{
            script {
            dockerImage = docker.build(reg + ":$BUILD_NUMBER")
            }
        }
        post {  
            success {  
                echo 'Docker image built successfully.'  
            }  
            failure {  
                echo "Docker image could not be built."
            }  
        }
        }

        stage('push to dockerhub') {
        steps{
            script {
            docker.withRegistry( '', regID ) {
                dockerImage.push("latest")
            }
            }
        }
        post {  
            success {  
                echo 'Image pushed successfully.'  
            }  
            failure {  
                echo "Image could not be pushed."
            }  
        }
        }

        stage('remove unused image') {
        steps{
            sh "docker rmi $reg:$BUILD_NUMBER"
        }
        }
    }
}
