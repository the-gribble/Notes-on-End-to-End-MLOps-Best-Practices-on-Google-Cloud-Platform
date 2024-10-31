# Classification Model Deployment - XGBoost

Here we will use our pipeline to deploy a data science model for inferences purposes.

**Objective:** CI/CD of XGBoost Classification Model for in-vehicle coupon recommendation.

High Level Steps:

1. Model training to generate the model artifact (*.pkl file, or pickle file)
2. Execute ...
...

Link to model: https://archive.ics.uci.edu/dataset/603/in%2Bvehicle%2Bcoupon%2Brecommendation

## Installing The Required Packages

We will be focusing on the following project directory: cloudrun-ml-models/coupon-recommendations

From the above directory, install the required packages: `pip install -r requirements.txt`

### Jupyter Notebooks

You may use the Jupyter Notebooks you get for Visual Studio Code, or you can install Jupyter locally and run a local server.

Install the package: `pip install jupyter`
Run the server from the root of the project: `jupyter notebook`

## Deploying A Flask App To Load Model To Serve Predictions

### Using a model in a remote bucket
Create a new storage bucket in your GCP account with the name: [your-project-id]-models

Inside teh "coupon_recommendations" directory you will see a file named main.py. You'll need to edit this file to update it with your newly created bucket name of [your-project-id]-models (replace your-project-id with your actual project ID).

Copy the following file into your newly created bucket: artifacts/xgboost_coupon_recommendation.pkl

### Run The App

Run: `python3 main.py`

### Test Your Deployed Model

Run the CURL command found in file "test-flask-output-local.sh". You should get a predicted value back.