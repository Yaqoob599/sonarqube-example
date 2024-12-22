pipeline{
    agent any
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
        stage('Docker Build') {
            steps {
                sh 'docker build -t app:latest .'
            }
        }
        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-cred', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh 'echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
                    sh 'docker push app:latest'
                }
            }
        }
        stage('Deploy') {
            steps {
                sh 'docker run -d -p 8080:8080 app:latest'
            }
        }
    }
}
