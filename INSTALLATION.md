# Jenkins Installation

This sections explains how to install Jenkins server and add configurations and new pipeline, using `Pipeline As Code (PAC)` and `Pipeline Configuration As Code (PCaC)`

### Jenkins Server Installation
> Perhaps this is the only manual action that is needed.

To install Jenkins server, issue the following commands
```
$ brew install jenkins-lts
$ brew services start jenkins-lts
```
Jenkins server can be accessed from http://localhost:8080/.
Please choose `Install suggested Plugins` option and create a new user `admin` from the self explaining pages.

At this point in time, you should see that [jenkins server up and running screen.](images/jenkins-server-up-and-running.png)

- [x] Jenkins Server is up and running.

## Jenkins Server Configuration
Import Jenkins plugin and configuration, mentioned as `Pipeline Configuration As Code (PCaC)` namely [jenkins.yaml](jenkins.yaml), by following this journey.

Jenkins > Manage Jenkins > Configuration as Code > Reload existing configuration and choose [jenkins.yaml](jenkins.yaml)

At this point in time, you should see that [jenkins tool and plugin configurations are set.](images/jenkins-plugin-configurations.png)

- [x] Jenkins Server is up and running.
- [x] Jenkins configurations are applied.

## New Jenkins pipeline Job
Piepline is again defined as a Code. Jenkins uses GDSL (Generic Data Structures Library) declarative language to define a pipeline. 

Use [web-e2e-tests-pipeline.gdsl](web-e2e-tests-pipeline.gdsl) to create a new pipeline Job.

At this point in time, you should see that [a new piepline to run web-e2e-tests](images/new-web-e2e-tests-pipeline.png) is created.

- [x] Jenkins Server is up and running.
- [x] Jenkins configurations are applied.
- [x] New pipeline to run web-e2e-tests is created.

