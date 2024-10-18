# Step-1
docker buildx build --platform linux/amd64 -t demo-flask-app .

# Push to Container Registry 
docker tag demo-flask-app gcr.io/mlops-best-practice/demo-flask-app
docker push gcr.io/mlops-best-practice/demo-flask-app

# To rebuild an existing container if code changes were made to the app, you can rebuild and push in one go, keeping the same tag.
# docker buildx build --platform linux/amd64 -t gcr.io/mlops-best-practice/demo-flask-app --push .

gcloud run deploy demo-flask-app --image gcr.io/mlops-best-practice/demo-flask-app --region us-central1

# Push to Artifact Registry 
docker tag demo-flask-app us-central1-docker.pkg.dev/mlops-best-practice/python-apps/demo-flask-app
docker push us-central1-docker.pkg.dev/mlops-best-practice/python-apps/demo-flask-app

gcloud run deploy demo-flask-app2 \
--image us-central1-docker.pkg.dev/mlops-best-practice/python-apps/demo-flask-app \
--region us-central1