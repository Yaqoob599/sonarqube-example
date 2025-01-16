pipeline{
    agent any
    environment {
        DOCKER_HUB_REPO = "venkatchalla841/myapplications" 
    }
    stages{
       stage('Git Checkout Stage'){
            steps{
                git branch: 'main', url: 'https://github.com/Yaqoob599/sonarqube-example.git'
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
                      -Dsonar.host.url=http://15.206.94.130:9000 \
                      -Dsonar.login=squ_52adeabc24df0c7bff0d7faa18d3bbd2527f5c66
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
