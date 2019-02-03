   pipeline {
    agent  any
   tools {
       maven 'maven'
        jdk 'java1.8.0'
    }
   stages {
   stage('Setup') {
            steps {
                script {
                    startZap(host: "127.0.0.1", port: 8080, timeout:10500, zapHome: "/opt/zaproxy", sessionPath:"~/target/session.session", allowedHosts:['github.com'])
                }
            }
        }
        stage('Build & Test') {
            steps {
                script {
                    sh "mvn verify -Dhttp.proxyHost=127.0.0.1 -Dhttp.proxyPort=8080 -Dhttps.proxyHost=127.0.0.1 -Dhttps.proxyPort=8080" // Proxy tests through ZAP
                }
            }
        }
    }
    post {
        always {
            script {
                archiveZap(failAllAlerts: 1, failHighAlerts: 0, failMediumAlerts: 0, failLowAlerts: 0, falsePositivesFilePath: "zapFalsePositives.json")
            }
        }
    }
}
