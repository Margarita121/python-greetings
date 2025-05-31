pipeline {
    agent any
    // triggers{
    //     pollSCM('*/1 * * * *')
    // }
    stages {
        stage('build-docker-image') {
            steps {
                buildApp()
            }
        }
        stage('deploy-to-dev') {
            steps {
                deploy("dev")
            }
        }
        stage('tests-on-dev') {
            steps {
                test("dev")
            }
        }
        stage('deploy-to-stg') {
            steps {
                deploy("stg")
            }
        }
        stage('tests-on-stg') {
            steps {
                test("stg")
            }
        }
        stage('deploy-to-prod') {
            steps {
                deploy("prd")
            }
        }
        stage('tests-on-prod') {
            steps {
                test("prod")
            }
        }
    }
}

def buildApp(){
    echo "Building of Python microservice is starting.."
    sh "docker build -t margarita121/python-greetings-app ."

    echo "Pushing image to docker registry.."
    sh "docker push margarita121/python-greetings-app"
}

def deploy(String environment){
    echo "Deployment of Python microservice on ${environment} environment.."
    sh "docker pull margarita121/python-greetings-app"
    sh "docker compose stop greetings-app-${environment}"
    sh "docker compose rm greetings-app-${environment}"
    sh "docker compose up -d greetings-app-${environment}"
}

def test(String environment){
    echo "API test execution against Python microservice on ${environment} environment.."
    sh "docker pull margarita121/api-tests-final"
    def directory = pwd()
    sh "echo '${directory}'"
    sh "docker run --network=host --rm margarita121/api-tests-final:latest run greetings greetings_${environment}"
    sh "ls"
}