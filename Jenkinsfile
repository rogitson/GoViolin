pipeline{
    
    agent any

    environment {
        dockerImg = ''
        reg = "rogitson/goviolin"
        regID = 'dockerhub'
        regURL = 'https://registry.hub.docker.com'
//         dockerhub = credentials('dockerhub')
    }

    stages {
        stage('build') {
        steps{
            script {
            dockerImg = docker.build(reg + ":$BUILD_NUMBER")
            }
//             sh 'docker build . -t rogitson/goviolin:$BUILD_NUMBER'
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
                dockerImg.push("latest")
            }
            }
//             sh 'docker tag rogitson/goviolin:$BUILD_NUMBER rogitson/goviolin:latest'
//             sh 'echo $dockerhub_PSW | docker login -u $dockerhub_USR --password-stdin'
//             sh 'docker push rogitson/goviolin:latest'
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
