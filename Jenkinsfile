#!groovy

node {
    environment = (env.ENV != null && env.ENV) ? env.ENV : 'prod'
    branch = (env.branch != null && env.branch) ? env.branch : 'main'
    browser = (env.browser != null && env.browser) ? env.browser : 'chrome'
    repoUrl = scm.getUserRemoteConfigs()[0].getUrl()
    dockerHome = tool 'docker'
    env.PATH = "${dockerHome}/bin:${env.PATH}"
    branchExists = false
    originalBranch = branch
    
    echo "environment : ${environment}"
    echo "branch : ${branch}"
    echo "browser : ${browser}"
    echo "repoUrl : ${repoUrl}"

    stage('Init') {
        deleteDir()
        
        // git branch checkout
        gitList = sh(
            script: "git ls-remote ${repoUrl} refs/heads/${branch}",
            returnStdout: true
        ).trim()
        echo "gitList: ${gitList}"
        if (gitList.length() > 0) {
            echo "Branch ${branch} exists and checking out."
            branchExists = true
        } else {
            // Fallback to default "main" branch,
            // when branch mentioned in pipeline build parameters do not exist
            echo "Branch ${branch} do exist and checking out main branch."
            branch = 'main'
        }
        
        // checkout web e2e test repo
        try {
            checkout([
                $class: 'GitSCM',
                branches: [[name: "${branch}"]],
                extensions: [],
                userRemoteConfigs: [[url: "${repoUrl}"]]
            ])
        } catch (err) {
            echo "Checkout failed."
            throw (err)
        }
    }

    stage ('Build') {
        // Build docker image for web e2e test
        buildCommand = "docker build \
                        --build-arg ENV=${environment} \
                        --build-arg BROWSER=${browser} \
                        --tag web-e2e-tests:${branch} ."
        sh "${buildCommand}"
    }

    stage ('Run') {
        // Run tests in a docker container
        withCredentials([string(credentialsId: 'cypress-dashboard-key', variable: 'CYPRESS_KEY')]) {
            ansiColor('xterm') {
                runCommand = "docker run \
                             -e ENV=${environment} \
                             -e BROWSER=${browser} \
                             -e CYPRESS_KEY=${CYPRESS_KEY} \
                             web-e2e-tests:${branch} "
                sh "${runCommand}"
            }
        }
        if (!branchExists) {
            unstable("Tests are passed. But the chosen branch: ${originalBranch} do not exist. So, marking this job as UNSTABLE")
        }
    }
}
