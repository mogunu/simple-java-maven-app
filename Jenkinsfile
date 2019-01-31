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
                sh 'scp -o StrictHostKeyChecking=no -i /tmp/my.pem target/my-app-1.0-SNAPSHOT.jar centos@54.149.242.5:/tmp/'
                sh 'ssh -i /tmp/my.pem centos@54.149.242.5 java -jar /tmp/my-app-1.0-SNAPSHOT.jar'
            }
        }
        
        stage ('Clone') {

            steps {

                git branch: 'master', url: "https://github.com/mogunu/simple-java-maven-app.git"

            }

        }



        stage('Artifactory Configuration'){
                steps{
                    rtServer (
                     id: "ARTIFACTORY_SERVER"   ,
                     url: "http://35.162.82.35:8081/artifactory/",
                     credentialsId: "8d292339-739e-4cae-8dbd-34a4b974108f"
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
