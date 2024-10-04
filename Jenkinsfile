pipeline {
    agent any
    tools {
        maven 'maven3'
    }
   environment {
        SONAR_HOME = tool "scanner"
    }
    
    stages {
        stage('1. Git Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/adenugabi/FullStack-Blogging-App.git'
            }
        }
                stage('2. Compile') {
            steps {
                sh "mvn compile"
            }
        }
                stage('3. Test') {
            steps {
                sh "mvn test"
            }
        }
                stage('4. Build ') {
            steps {
                sh 'mvn package'
            }
        }
                        stage('5. Static Code Analysis') {
            steps {
                script {
             withSonarQubeEnv(credentialsId: 'sonarqube-cred') {
                sh "mvn sonar:sonar"
}
}
            }
        }
            stage('5. upload to artifacts') {
            steps {
                withMaven(globalMavenSettingsConfig: 'nexus-cred', jdk: '', maven: 'maven3', mavenSettingsConfig: '', traceability: true) {
                sh "mvn deploy"
}
            }
        }
                stage('6. Build Image') {
            steps {
                withDockerRegistry(credentialsId: 'docker-credential', url: 'https://registry.hub.docker.com') {
            sh "docker build -t bhisawlah/blogging-app ."
}
            }
        }
                stage('7. Docker Push') {
             steps {
                withDockerRegistry(credentialsId: 'docker-credential', url: 'https://index.docker.io/v1/') {
                sh "docker push bhisawlah/blogging-app:latest"
                }
            }
        }
        
    
                stage('8. Deploy to kubernetes') {
            steps {
                withKubeConfig(caCertificate: '', clusterName: 'fullstack-cluster', contextName: '', credentialsId: 'k8s-credential', namespace: 'webapps', restrictKubeConfigAccess: false, serverUrl: 'https://BE07C33565AF95E78404E370F07679ED.gr7.eu-west-2.eks.amazonaws.com') {
                    sh "kubectl apply -f deployment-service.yml"
                    sleep 30
}
            }
        }
        
                stage('9. confirm Deployment') {
            steps {
                withKubeConfig(caCertificate: '', clusterName: 'fullstack-cluster', contextName: '', credentialsId: 'k8s-credential', namespace: 'webapps', restrictKubeConfigAccess: false, serverUrl: 'https://BE07C33565AF95E78404E370F07679ED.gr7.eu-west-2.eks.amazonaws.com') {
                    sh "kubectl get svc -n webapps"
                    sh "kubectl get pods -n webapps"
}
            }
        }
      stage('10. Email notification') {
    steps {
        script {
         withKubeCredentials(kubectlCredentials: [[
            caCertificate: '', 
            clusterName: 'fullstack-cluster', 
            contextName: '', 
            credentialsId: 'k8s-credential', 
            namespace: 'webapps', 
            restrictKubeConfigAccess: false, 
            serverUrl: 'https://BE07C33565AF95E78404E370F07679ED.gr7.eu-west-2.eks.amazonaws.com'
        ]] ) {
            def kubectlOutput = sh(script: 'kubectl get svc -n webapps', returnStdout: true).trim()

            emailext(
                to: 'ajisegbedeabisolat@gmail.com',
                subject: 'Deployment Successful',
                body: """Your deployment was successful.

                Here is the current status of services in the webapps namespace:

                ${kubectlOutput}

                Regards,
                Abisola Tracy Adenuga
                """,
                mimeType: 'text/html'  // Consider using HTML for richer content
            )
        }
    }
}
}
}
}
