pipeline {
    agent  any
   tools {
       maven 'maven'
        jdk 'java1.8.0'
    }
    stages {
        stage('Build') {
            steps {
                sh 'mvn -B -DskipTests clean package'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
        }
        
        stage ('Clone') {
            steps {
                git branch: 'master', url: "https://github.com/mogunu/simple-java-maven-app.git"
            }
        }
          }
        }
    
