# Cloud Run for ML Models
Cloud Run: A serverless compute environment for containerise applications on Google Cloud.

In this section we will review what Cloud Run is, and then practice using Cloud Run by deploying a python Flask app (a light weight web application framework).

## Overview of Cloud Run
 - **Serverless:** You only need to focus on writing your code. Google takes care of the infrastructure, including server provisioning, maintenance, scaling, and logging.
 - **Containers:** Applications are packaged as Docker containers, allowing for consistency between local development and produciton environments.
 - **Auto-Scaling:** Cloud Run will automatically scale the number of containers based on incoming traffic. 
 - **Pay-For-What-You-Use:** Billing is based on the number of requests, the time your code is running, and the amount of memory consumed. 
 - **CI/CD:** Integration with Google Cloud Build allows for automated builds and deployments.

## Popular Use Cases for Cloud Run
 - **Web Applications:** Deploy and scale web applications quickly without managing the underlying infrastructure.
 - **API Endpoints:** Internal microservices or external-facing APIs.
 - **Event-driven Applications:** Integrate with services like Google Cloud Pub/Sub to handle event-driven workloads.
 - **Data Processing & ETL Jobs:** Execute ETL (Extract, Transform, Load) tasks in response to events, such as the arrival of new data.
 - **ML Model Serving:** Deploy trained machine learning models for inference without setting up dedicated infrastructure. Achieve low-latency predicitons using auto-scaling based on incoming request volumes.

 ## Deploying a Flask Application to Cloud Run
 Ingest a CSV file from a GCS bucket into a BigQuery table every time it's invoked.

 Steps:
 1. Containerise a Flask application which ingests a CSV file into a BigQuery table.
 2. Push the container to Google Container Registry(GCR) / Google Artifact Registry (GAR).
 3. Deploy the container image from GCR & GAR to Cloud Run.
 4. Execute and test the Pytest script for the flask application from the local system.
 5. Deploy the application using Cloud Build steps for automated builds, testing, and deployment.
 6. Setup a GitHub repository and Cloud Build triggersto automate CI/CD on Git commits and code changes.

You'll find sample application code in the **"cloudrun-app"** folder in the root of the project.

 ### Uploading our CSV file to a bucket

 Let's get ready to deploy our flask app. We'll need a CSV file to ingest. This needs to be uploaded to a Google Cloud Storage (GCS) bucket: a cloud object store service. You'll find the CSV file named "us-states.csv" in the "cloudrun-app" project folder in the root of this repo.

 Navigate to the following in Google cloud console: Main Menu (left-hand side) > Cloud Storage > Buckets

 At the top, click on "Create".
 ![create-gcs-bucket](/docs/section_2/images/create_gcs_bucket.png)
 
 Enter bucket name and click "Continue"
 ![create-gcs-bucket-name](/docs/section_2/images/create-gcs-bucket-name.png)

Where to store your data - if you've like, you can leave the default storage location of US Multi-region, or you could select a local region in your country for best performance. Click "Continue"
![create-gcs-bucket-region](/docs/section_2/images/create-gcs-bucket-region.png)

Click "Continue" past selecting the type/class of starge. In short: the less available your data (the lower down the provided list), the cheaper.

Click "Continue" past access control.

Accept the default data protection setting and click "Create". Click "Confirm" when/if asked to prevent public access. Your new bucket will be shown, and selected.

Click the "upload" button and upload our test data file (us-states.csv) to your new bucket.
![create-gcs-bucket-upload](/docs/section_2/images/create-gcs-bucket-upload.png)

Your file should now be uploaded to a bucket.
![create-gcs-bucket-new-file](/docs/section_2/images/create-gcs-bucket-new-file.png)

### The Flask Application

#### Updating The App Code

Before the code will successfully run, you'll need to update the code to reflext your project ID and the new bucket you created.

Open the `main.py` file in the folder "cloudrun-app/application-files".

On line 11 you will need to replace the project ID with your own project ID: `table_id = "[your-project-id].test_schema.us_states"`

This line will then look something like this: `table_id = "mlops-best-practice.test_schema.us_states"`.

Next, update the code on line 17 to add your new bucket name: `uri = "gs://[your-bucket-name]/us-states.csv"`

The code would look like this: `uri = "gs://mlops-cloud-run-source/us-states.csv"`

![get-bucket-name-1](/docs/section_2/images/get-bucket-name-1.png)

![get-bucket-name-2](/docs/section_2/images/get-bucket-name-2.png)

#### Ensure Requirements Are Met

If you've not done so already, you'll need to install the required python packages. A list of packages needed can be found in the requirements file: /cloudrun-app/application-files/requirements.txt.

To process the requirements file and have the packages installed, run the following from the /cloudrun-app/application-files folder: pip install -r requirements.txt

#### Build Container
We will start by running the commands in the file "docker-cloudrun-commands.sh" manually, line-by-line, to get famoiliar with them. 

In the "cloudrun-app/application-files" folder, copy & run the following command to build your docker container (will will not run at this time): 
`docker buildx build --platform linux/amd64 -t demo-flask-app .`

#### Push To The Container Registry
Next, let's push to the container registry. Replace text as needed and run the following:

`docker tag demo-flask-app gcr.io/[your_project_ID]/demo-flask-app`
`docker push gcr.io/[your_project_ID]/demo-flask-app`

Replace [your_project_ID] with the name of your GCP project ID. FOr example, mine is "mlops-best-practice".

My commands would then look like this:

`docker tag demo-flask-app gcr.io/mlops-best-practice/demo-flask-app`
`docker push gcr.io/mlops-best-practice/demo-flask-app`

Get project ID.
![get-project-id](/docs/section_2/images/get-project-id.png)

You will get errors like "403 Forbidden" if you've not logged into your account correctly via glcoud on the command line. Do that [HERE](/gcloud_commands_to_get_started.txt) if you've not done that already.

In GCP, go to the Container Registry page to view your newly-pushed container.
![view-your-container-1](/docs/section_2/images/view-your-container-in-gcr-1.png)

![view-your-container-2](/docs/section_2/images/view-your-container-in-gcr-2.png)

![view-your-container-3](/docs/section_2/images/view-your-container-in-gcr-3.png)

#### Deploy To Cloud Run

The next command is: `gcloud run deploy demo-flask-app --image gcr.io/[your_project_ID]/demo-flask-app --region us-central1`

Replace "[your_project_ID]" with your project ID.

If you get a message like the following, just enter "y".
![enable-cloud-run](/docs/section_2/images/enable-cloud-run-cmd-line.png)

Enter "Y" if you're asked to allow unauthenticated invocation.
![allow-unauthenticated-invocation](/docs/section_2/images/allow-unauthenticated-invocation.png)

When successful, you'll see the following.
![deployed-to-cloud-run](/docs/section_2/images/deployed-to-cloud-run.png)

The invocation URL will look like this (do not trigger yet!): https://demo-flask-app-274838570460.us-central1.run.app

Do not invoke the URL as you'll get an error as it will try to write to BigQuery.

For the purposes of training we've set this up to not require authentication. This is not the correct way to do this properly, and should definately not be done this way in production.

You can head to the Cloud Run page in GCP to view your run instance.
![cloud-run-instance](/docs/section_2/images/cloudrun-instance.png)

#### Create BigQuery Table

Navigate to BigQuery via the side menu. 

In a new query window, execute the following SQL code to create our target table:

`create schema test_schema;`

`create or replace table [your_project_ID].test_schema.us_states
(
name STRING,
post_abbr STRING
);`

Replace "[your_project_ID]" with your project ID.

![create-bq-table](/docs/section_2/images/create-bq-table.png)

You'll see your BQ table in your new schema inside the dataset.
![bq-table-created](/docs/section_2/images/bq-table-created.png)

#### Test Trigger The Cloud Run App

Now you can trigger the Cloud Run app by invoking the URL previously presented. You can get that URL again by heading over to cloud run and opening your instance.

![cloud-run0instance](/docs/section_2/images/cloudrun-instance.png)

![cloudrun-url](/docs/section_2/images/cloudrun-url.png)

You can click on the URL on the Cloud Run screen to open a new tab and have the instance triggered. The successful output on the screen will be a count of the number of rows processed: {"data":50}

To confirm the data is indeed loaded in your BiqQuery table, navigate to BiqQuery, select you target table, and click the "Preview" tab to view your data.

![view-data-in-bq](/docs/section_2/images/view-data-in-bq.png)

**You have now succesfully deployed your cloud run application!**

## Deploying Your Flask App To Artifact Registry

Before you can deploy your app to artifact regsitry, you first need to create an artifact repository to hold your object.

### Create An Artifact Repository

Navigate to or search for "Artifact Registry". Click on "Create Repository".

![create-gar-repo-1](/docs/section_2/images/create-gar-repo-1.png)

Name the repo "python-apps" and select the "us-central1" location. Then click the "Create" button.

![create-gar-repo-2](/docs/section_2/images/create-gar-repo-2.png)

![create-gar-repo-3](/docs/section_2/images/create-gar-repo-3.png)

### Push Container To Artifact Registry

First you need to ensure the you have the required permission to write to the arifact registry. Run the following in the command line: `gcloud auth configure-docker us-central1-docker.pkg.dev`.

This will propagate the needed credentials. Answer "y" when asked.

Then, on the command line, run: `docker tag demo-flask-app us-central1-docker.pkg.dev/[your-project-id]/python-apps/demo-flask-app`

Replace "[your-project-ID]" with your project ID.

Your command should be similar to this: `docker tag demo-flask-app us-central1-docker.pkg.dev/mlops-best-practice/python-apps/demo-flask-app`

Next run this on the command line: `docker push us-central1-docker.pkg.dev/[your-project-ID]/python-apps/demo-flask-app`

Replace "[your-project-ID]" with your project ID.

Your command should be similar to this: `docker push us-central1-docker.pkg.dev/mlops-best-practice/python-apps/demo-flask-app`

### Deploy The Artifact To Cloud Run

If you're running an arm machine - like a Macbook M series - you may need to rebuild your image for linux. REbuild using: `docker buildx build --platform linux/amd64 -t us-central1-docker.pkg.dev/[your-project-id]/python-apps/demo-flask-app --push .`

You'll need to run the below in the command line to deploy your artifact to Cloud Run:

`gcloud run deploy demo-flask-app2 \
--image us-central1-docker.pkg.dev/[your-project-id]/python-apps/demo-flask-app \
--region us-central1`

You command should look similar to this:

`gcloud run deploy demo-flask-app2 \
--image us-central1-docker.pkg.dev/mlops-best-practice/python-apps/demo-flask-app \
--region us-central1`

Note that we've changed the name slightly to differenciate the apps in Cloud Run.

You can then go the the URL of the new cloud run instance to ingest 50m additional rows into you BigQuery table.

### Testing Locally with Pytest

To Run - in application_files folder run: `pytest test_main.py`