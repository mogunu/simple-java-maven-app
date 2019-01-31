pipeline {
   agent any
   
   tools {
        maven 'maven'
        jdk 'java1.8.0'
    }
    stages {
        stage('Build') {
            steps {
            
                sh "mvn -B -DskipTests clean package"
                }
           }
     }
 }
