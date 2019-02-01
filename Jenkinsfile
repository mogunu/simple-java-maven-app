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
                sh 'scp -o StrictHostKeyChecking=no -i /tmp/my.pem target/my-app-1.0-SNAPSHOT.jar centos@34.217.29.143:/tmp/'
                sh 'ssh -i /tmp/my.pem centos@34.217.29.143 java -jar /tmp/my-app-1.0-SNAPSHOT.jar'
            }
        }
        
        stage ('Clone') {

            steps {

                git branch: 'master', url: "https://github.com/mogunu/simple-java-maven-app.git"

            }

        }

stage('sonar') {
            steps {
                sh 'mvn sonar:sonar -Dsonar.host.url=http://35.164.31.242:9000 -Dsonar.login=bba851051e781d45abceee2474eea8df2e0e6a37'
            }
}
    
        stage('Artifactory Configuration'){
                steps{
                    rtServer (
                     id: "ARTIFACTORY_SERVER"   ,
                     url: "http://35.164.31.242:8081/artifactory",
                     credentialsId: "artifactory"
                    )
                
                
                rtMavenDeployer (
                    id: "MAVEN_DEPLOYER",
                    serverId: "ARTIFACTORY_SERVER",
                    releaseRepo: "libs-release-local",
                    snapshotRepo:"libs-snapshot-local"
                    
                    )
                    
                    rtMavenResolver (
                        id: "MAVEN_RESOLVER",
                        serverId: "ARTIFACTORY_SERVER",
                        releaseRepo:"libs-release",
                        snapshotRepo:"libs-snapshot"
                        
                        )
                }
            }
            
        stage ('Exec Maven'){
            steps {
                rtMavenRun(
                    tool: 'maven',
                    pom: 'pom.xml',
                    goals: 'clean install',
                    deployerId: "MAVEN_DEPLOYER",
                    resolverId: "MAVEN_RESOLVER"
                    
                    )
            }
        }
            
        stage ('Publish build info') {
            steps{
                rtPublishBuildInfo (
                        serverId: "ARTIFACTORY_SERVER"
                    )
            }
        }
    
    }    
}
