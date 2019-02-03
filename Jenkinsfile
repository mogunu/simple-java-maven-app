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
        stage('Deploy') {
            steps {
                //sh './jenkins/scripts/deliver.sh'
                //sh 'scp -o StrictHostKeyChecking=no -i /tmp/my.pem target/my-app-1.0-SNAPSHOT.jar centos@34.217.29.143:/tmp/'
                //sh 'ssh -i /tmp/my.pem centos@34.217.29.143 java -jar /tmp/my-app-1.0-SNAPSHOT.jar'
            }
        }
        
        stage ('Clone') {
            steps {
                git branch: 'master', url: "https://github.com/mogunu/simple-java-maven-app.git"
            }
        }
          }
        }
    
