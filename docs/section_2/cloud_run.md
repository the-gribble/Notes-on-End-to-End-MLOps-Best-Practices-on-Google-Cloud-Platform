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
 ![create-gcs-bucket](/docs/images/create_gcs_bucket.png)
 
 Enter bucket name and click "Continue"
 ![create-gcs-bucket-name](/docs/images/create-gcs-bucket-name.png)

Where to store your data - if you've like, you can leave the default storage location of US Multi-region, or you could select a local region in your country for best performance. Click "Continue"
![create-gcs-bucket-region](/docs/images/create-gcs-bucket-region.png)

Click "Continue" past selecting the type/class of starge. In short: the less available your data (the lower down the provided list), the cheaper.

Click "Continue" past access control.

Accept the default data protection setting and click "Create". Click "Confirm" when/if asked to prevent public access. Your new bucket will be shown, and selected.

Click the "upload" button and upload our test data file (us-states.csv) to your new bucket.
![create-gcs-bucket-upload](/docs/images/create-gcs-bucket-upload.png)

Your file should now be uploaded to a bucket.
![create-gcs-bucket-new-file](/docs/images/create-gcs-bucket-new-file.png)

 ### The Flask Application

You'll find 