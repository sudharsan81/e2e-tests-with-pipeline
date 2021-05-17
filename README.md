# Web e2e tests with pipeline
This repository contains a web e2e test framework and the necessary pipeline as a code.

## Objectives
The objectives of this repository are :

- Define pipeline, pipeline plugins and pipeline tool configurations as `code`.  commonly known as `Pipeline As Code (PAC)` and `Pipeline Configuration As Code (PCaC)`.
- Define pipeline gating policies.
- Describe various stages of the pipeline like initialisation, build and run stages.
- Demonstrate contanerisation as a reliable rumtime to run tests within pipeline agents.
- Demonstrate `cypress` as a web based test automation framework.
- Demonstrate test results dashbaords and analytics.

If you want to view the recorded demonstration, please go to [Demo](#Demo) directly.

## Software pre-requisites
- macOs (preferred for the demo).
- Docker desktop, any stable version.

## Pipeline installation
If user is familiar with Jenkins Pipeline, please use these `Pipeline As Code (PAC)` and `Pipeline Configuration As Code (PCaC)`.

| Code | Purpose | What we see on success ?|
|------|---------|------------|
|[jenkins.yaml](jenkins.yaml) |Jenkins plugin and tool configurations as code.| [Jenkins Plugins](images/jenkins-plugin-configurations.png) |
|[web-e2e-tests-pipeline.gdsl](web-e2e-tests-pipeline.gdsl) |Pipeline as a code defining build build parameters and scm configurations.| [New pipeline to run web-e2e-tests](images/new-web-e2e-tests-pipeline.png) |
| [Jenkinsfile](Jenkinsfile)| All stages within web-e2e-tests and quality gate policies are defined as groovy code. | - |

if user wants detailed installation instructions, please follow this [document](INSTALLATION.md).

## Pipeline strategy

| Thing | Strategy | Source |
|-------|----------|--------|
| Source code checkout in Jenkins | Pipeline build parameter provides parameterised way to choose web-e2e-tests branch to run tests.<BR><BR>In case such a branch do not exist, the pipeline fallsback to default branch.| [Jenkinsfile groovy code to checkout.](https://github.com/sudharsan81/e2e-tests-with-pipeline/blob/main/Jenkinsfile#L20) |
| Buil test service in pipeline | Test service is built as a docker image. | [Jenkins stage to build docker image.](https://github.com/sudharsan81/e2e-tests-with-pipeline/blob/main/Jenkinsfile#L49) |
| Run tests in pipeline | To have complete control over the environment that runs tests, docker containers are used.<BR><BR>During Jenkins configuratio, `docker` was installed in Jenkins agent. | [Jenkins stage that runs tests.](https://github.com/sudharsan81/e2e-tests-with-pipeline/blob/main/Jenkinsfile#L58) |
| Overall pipeline job status policy | <span style="color:red">**FAIL**</span> When tests fail or any stage of the pipeline fails.<BR><BR><span style="color:orange">**UNSTABLE**</span> When branch mentioned in the pipeline build parmeter do not exist and pipeline falls back to use web-e2e-tests master branch.<BR><BR><span style="color:green">**PASS**</span> When all tests pass.<BR><BR>| [Jenkins job status policy.](https://github.com/sudharsan81/e2e-tests-with-pipeline/blob/main/Jenkinsfile#L72)|
| Test automation framework structure | `cypress` is a modern web test automation framework. we can leverage all the benefits of using a modern test automation framework just by adopting it. cypress comes up with standard folder structure and they are conventions as well.<BR><BR>All environment specific variations are handled using `dictionary` defined in `cypress.json`<BR><BR>Test scripts written using cypress APIs, popularly called as `test specification files` are stored within `./cypress/integration`. Placing any mocha based test specfile in this folder makes it a candidate for execution. No additional configurations are needed.| [cypress environment dictionary](https://github.com/sudharsan81/e2e-tests-with-pipeline/blob/main/cypress.json) |
| web-e2e-tests pipleline trigerring policy | web-e2e-tests pipelines are trigerred by: <BR><BR> - Manual trigerring of the pipeline.<BR>- github webhook. Whenever a code is changed in the `master` branch, test pipeline is executed against pre-production evvironment.| -  |
| Test results dashboards and analytics | Although cypress is capable of creating mocha test reports and Jenkins has necessary plugins to display HTML reports, they do not provide anayltics.<BR><BR>I have used cypress Dasshboard Service for test reporting and test analytics purposes.<BR><BR>| Test analytics for this service can be accessed [here](https://dashboard.cypress.io/projects/vu5pyz/analytics/runs-over-time) <BR><BR>Test reports can be accessed [here](https://dashboard.cypress.io/projects/vu5pyz/runs)<BR><BR> |

## Run tests from Pipeline
- Access local Jenkins server from http://localhost:8080/
- Access web-e2e-tests pipeline http://localhost:8080/job/web-e2e-tests/
- Start Build http://localhost:8080/job/web-e2e-tests/build?delay=0sec
- Access test results dashboard from https://dashboard.cypress.io/projects/vu5pyz/runs
- Access test results Analytics from https://dashboard.cypress.io/projects/vu5pyz/analytics/runs-over-time


## Demo
Here is a recorded demonstration. Happy to provide the same demo in a zoom meeting.<BR><BR>
The following video demonstrates
- Pipeline job trigger.
- Pipeline job final status.
- User receives slack notification.
- User views test report dashbord.
- User views test report analytics.
<BR><BR>
[![Web E2E tests in a pipeline](https://i.ytimg.com/vi/3LKqcDaCuQk/hqdefault.jpg)](https://youtu.be/yJrCiASh3_U)
