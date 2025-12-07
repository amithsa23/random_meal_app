# Random Meal App - Docker Deployment

## Build and Run with Docker

### Option 1: Using Docker Compose (Recommended)

```bash
# Build and start the container
docker-compose up -d

# View logs
docker-compose logs -f

# Stop the container
docker-compose down
```

The app will be available at: http://localhost:8080

### Option 2: Using Docker directly

```bash
# Build the Docker image
docker build -t random-meal-app .

# Run the container
docker run -d -p 8080:80 --name random_meal_app random-meal-app

# View logs
docker logs -f random_meal_app

# Stop and remove the container
docker stop random_meal_app
docker rm random_meal_app
```

## Deployment to Cloud Platforms

### Deploy to Google Cloud Run

```bash
# Build and push to Google Container Registry
gcloud builds submit --tag gcr.io/YOUR_PROJECT_ID/random-meal-app

# Deploy to Cloud Run
gcloud run deploy random-meal-app \
  --image gcr.io/YOUR_PROJECT_ID/random-meal-app \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated
```

### Deploy to AWS (ECS/Fargate)

```bash
# Build and tag
docker build -t random-meal-app .

# Tag for ECR
docker tag random-meal-app:latest YOUR_ACCOUNT.dkr.ecr.us-east-1.amazonaws.com/random-meal-app:latest

# Push to ECR
docker push YOUR_ACCOUNT.dkr.ecr.us-east-1.amazonaws.com/random-meal-app:latest
```

### Deploy to Heroku

```bash
# Login to Heroku Container Registry
heroku container:login

# Build and push
heroku container:push web -a your-app-name

# Release the app
heroku container:release web -a your-app-name
```

## Environment Variables

If you need to add environment variables (for production API keys, etc.), modify `docker-compose.yml`:

```yaml
services:
  random-meal-app:
    environment:
      - API_URL=https://www.themealdb.com/api/json/v1/1
```

## Production Optimizations

For production, you might want to create a custom nginx configuration for better caching and performance.

## Notes

- The Dockerfile uses a multi-stage build to keep the final image small
- Stage 1: Builds the Flutter web app
- Stage 2: Serves the static files with nginx (only ~50MB)
- The app will be accessible on port 8080 (can be changed in docker-compose.yml)
