pipeline{
    agent any
    stages{
       stage('Git Checkout Stage'){
            steps{
                git branch: 'main', url: 'https://github.com/sudheer76R/sonarqube-example.git'
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
                    -Dsonar.host.url=http://98.81.170.87:9000 \
                    -Dsonar.login=sqp_d2ab8fe9634ae3654018b893e8e3e7222eaf8409'
            }
        }
    }
}
