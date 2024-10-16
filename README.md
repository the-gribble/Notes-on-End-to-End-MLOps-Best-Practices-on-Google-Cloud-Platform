# Notes on End-to-End MLOps Best Practices on Google Cloud Platform (GCP)

## Table of Contents
1. Introduction (This Readme)
2. [Lab Preparation: Services to enable in GCP to perform the labs](/docs/service_activation.md)
3. [Lab Preparation: Local development environment](/docs/local_environment_setup.md)

## Sections
 - Introduction to MLOps
 - CI/CD for cloud applications and ML models
 - Continuous training using GCP Composer / Airflow
 - Vertex AI
 - - Model Training
 - - Model Registry
 - - Batch & Online Predictions
 - Kubeflow pipelines for ML workflow orchestratino on Vertex AI
 - Hyperparameter tuning, model versioning, explainability of models, and feature store in Vertex AI
 Generative AI on VerexAI on GCP (brief intro)

## GCP Account
A trial GCP account is needed to complete this material.

## GCP Services Used
 - Python & Docker
 - Cloud Composer
 - Cloud Build
 - Cloud Container/Artifact Registry
 - Gcloud CLI
 - GCS Buckets
 - Cloud Logging/Alerting
 - Cloud Run & Cloud Functions
 - Vertex AI
 - - Model Training services
 - - Model Regitry
 - - Vertex AI End-Points
 - - Experiments
 - - Explainability AI
 - - Hyperparameter Jobs
 - - Feature Store
 - - Kubeflow (Pipelines)

## What is MLOps?
 - Refers to the combination of best practices, principles, and tools for deploying, monitoring, and maintaining machine learning models
 - Seeks to bridge the gap between the development of ML models (typically by data scientists) and their operation in real-world production settings.
 - Aims to streamline development and deployment for machine leaning pipelines and data science models.

## DevOps VS MLOps
### DevOps
 - Primarily focused on code coverage, functionality, and unit tests
 - Focused on deploying and serving application code
 - **Testing:** Primarily focused on code quality and funcitonal testing
 - Software engineering focuses on system performance, error tracking, and log analysis.

 ### MLOps
  - The focus is not only on the code, but also on the data, such as data validation, retraining, model evaluation, automated model artifact deployment, etc.
  - Deals with versioning and managing machine learning models. I.e. Model training code and model inference code.
  - **Testing:** Incorporates continuous data validation techniques such as data validation checks, missing values, and schema validation.
  - ML-Ops tracks model metrics, data quality, and continuous drift detection.

## Why do we need MLOps?
ML code is actually a small part of an ML implementation, or aspect of machine learning. MLOps imvolves several other aspects that are extremely crutial for a data science model to be useful and successful to an organisation. 

This involves:
 - Appropriate infrastructure selection for model training and serving.
 - Data validation
 - Automated pipelines
 - Continuous training
 - Model Versioning
 - Testing & monitoring
 - and more

## Key Pricipals & Components of MLOps
Machine learning can be broadly categorised into four aspects:
 - Data Science - problems to solve
 - - Business requirements & stakeholder management (functional)
 - - Data pre-processing & EDA (Exploratory Data Analysis)
 - - Chosing a framework: Scikit-learn, XGBoost, Tensorflow, etc
 - - Model evaluation and training <= this course teaches you from this point onwards
 - - Model serviing

 - Pipeline Components - purely technical
 - - Continuous model training pipeline
 - - Reusable pipelines and components
 - - - Each step is reuable and can be triggered seperately

 - Continous Integration / Continuous Delivery (or Deployment if fully automated) - CI/CD
 - - Choosing the right tools
 - - Code versioning system/repository
 - - Automated deployment

 - Other Aspects
 - - Feature store / hyperparameter tuning / experiments
 - - Performance Monitoring
 - - Model Versioning

## Continuous Integration (CI) and Delivery/Deployment (CD)
 - CI: (in ML) revolves around the automated integration of code and data changes into the main project. It ensures that the new code/data introduced doesn't introduce issues or degrade model performance. This happens during development.

 - CD: (in ML) is the automated deployment of ML models into production, ensuring that the servers are always updated with the latest version of the data science model. This happens after development.

### Steps Involved

CI: 
 - Source code versioning in your repository
 - Autmoated builds
 - Automated testing

CD: 
 - Continuous deployment to the production environment
 - Monitoring & alerting

CI/CD Flow
![CI/CD Flow](/docs/images/ci-cd-flow.drawio.png)

## Artifact and Container Registries

These can be considered two of the most important services available in GCP when performing MLOps and CI/CD in general.

 - **Google Artifact Registry** (GAR) is a services that helps you manage and store your software packages securely. Can store multiple different types of artifacts, including Docker images.

 Example: Deploying a docker image, then deploying a java app to cloud run, then deploying python code to Vertex AI, and so on.
 - **Google Container Registry** (GCR) is a service that helps you manage and store your Docker images securely. GCR is a private container regsitry service.

 Example: Deploying a docker image to Cloud run, then deploying a different Docker image to Vertex AI.

 ![CI/CD Flow with Regsitry](/docs/images/ci-cd-flow-with-registry.drawio.png)

