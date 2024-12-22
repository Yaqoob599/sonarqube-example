pipeline{
    agent any
    environment {
        DOCKER_HUB_REPO = "venkatchalla841/myapplications" 
    }
    stages{
       stage('Git Checkout Stage'){
            steps{
                git branch: 'main', url: 'https://github.com/guruvenkatakrishna/sonarqube-example.git'
            }
         }        
       stage('Build Stage'){
            steps{
                sh 'mvn clean install'
            }
         
        }
        stage ('sonar analysis'){
            steps{
                sh 'mvn clean verify sonar:sonar \
                    -Dsonar.projectKey=sonarcheck \
                    -Dsonar.host.url=http://54.234.49.251:9000 \
                    -Dsonar.login=sqp_bbc2166473d82d28b5aefc67a6488da5aa289fff'
            }
        }
        stage('Build Artifact') {
            steps {
                sh 'mvn package'
            }
        }
        stage('Login to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-cred', 
                                                  usernameVariable: 'DOCKER_HUB_USERNAME', 
                                                  passwordVariable: 'DOCKER_HUB_PASSWORD')]) {
                    sh """
                    echo $DOCKER_HUB_PASSWORD | docker login --username $DOCKER_HUB_USERNAME --password-stdin
                    """
                }
            }
        }
        stage('Docker Build') {
            steps {
                sh 'docker build -t ${DOCKER_HUB_REPO}:latest1 .'
            }
        }
        stage('Push to Docker Hub') {
            steps {
                sh """ docker push ${DOCKER_HUB_REPO}:latest1 """
                
                }
        }
        stage('Deploy') {
            steps {
                sh 'docker run -d -p 8080:8080 ${DOCKER_HUB_REPO}:latest1'
            }
        }
    }
}
