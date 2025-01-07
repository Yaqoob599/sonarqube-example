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
                sh 'mvn clean compile'
            }
         
        }
        stage ('sonar analysis'){
            steps{
                sh 'mvn clean verify sonar:sonar \
                      -Dsonar.projectKey=cicd-deploy \
                      -Dsonar.host.url=http://52.90.96.16:9000 \
                      -Dsonar.login=sqp_c3590a66ae435ddff9f54898c795d05a4219e180'
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
                sh 'docker run -d -p 8000:8080 ${DOCKER_HUB_REPO}:latest1'
            }
        }
    }
}
