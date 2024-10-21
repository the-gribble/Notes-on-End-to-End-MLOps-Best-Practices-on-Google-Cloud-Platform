# Cloud Build

Cloud Build is Googles fully managed CI/CD platform. It lets developers build, test, and deploy their applications in the cloud.

Features of Cloud Build:
 - Serverless
 - Integrated with GCP services
 - Speed & Security

## The role of Cloud Build

Defines CI/CD workflow, much like GitLab CI.

### CI Function
 - Automated Builds
 - Running Tests
 - Isolation

### CD Function
 - Deployment to GCP services

### Configuratble via cloudbuild.yaml

CI/CD workflows are typically defined in a cloudbuild.yaml file, where you specify build steps, their order, and other configurations.

### Build History & Logs

Cloud Build keeps a history of all your builds, allowing you to go back and see logs, artifacts, and other details of past builds.

### Integration & Triggers

Cloud Build can integrate with popular version control platform and can be triggered on events like code commits, pull requets, or manual initiation.

## Implement Cloud Build

Refer to the code contained in the code project folder: cloudrun-app-cloudbuild/application-files

Within there, look for the cloudbuild.yaml file to see the build pipeline. This script contains 4 steps: build container, push container to container registry, run the tests (any script that starts with the word 'test'), and deploy to cloud run.

These steps represent the same form of steps we manually carried out for Cloud Run previously.

### Set Cloud Build Permissions

In the same project, look for the file: gcloud-permission-commands.sh. In there will be the steps required to setup permissions. Change the project ID and project number (forming part of the service account name) as needed. You can get the project number from the dashboard of your project, under "Project info".

### Trigger Cloud Build

In the same project, look for the file: gcloud-coudbuild-trigger.sh. In there you'll find the locaol command to trigger cloud build.

Run this from the application-files directory. The command needs to see the cloudbuild.yaml file.

Triggering the build will ultimately overwrite our first Cloud Run Flask app.

## Cloud Build trgigers & GitHub

For this tasks we'll be using a different yaml file. Rename the cloudbuild.yaml file to cloudbuild-old.yaml. Then, rename cloudbuild-git.yaml to cloudbuild.yaml.

We would then be using the Git version of the build file.

The main difference is that we'll be using a Cimmit SHA: a uniqueidentifier for a commit. This is used for traceability in Github. I.e. you can map what change resulted in a particular error.

Create a new Github repo, of any name, and upload the following files from the clourun-app-cloudbuild proejct: Dockerfile, cloudbuild.yaml, main.py, requirements.txt, and test_main.py.

### Enable API & Services

You'll need to enable an API to continue: Enable APIs & Services > Click "Enable APIs & Serices" button, in search bar enter "API" to find "Identity and Access Management (AIM) API".

Select that API and hit "Enable".

### Connect Repository

Go to Cloud Build, then "Trigger", then "Connect Repository" (assuming this is the very first repo you're connecting).

Use default region. Go through the steps to connect a GitHub account.

...

### Create a trigger in Cloud Build

...

When you make changes to a file in GitHub, the Cloud Build process will then be triggered automatically.
