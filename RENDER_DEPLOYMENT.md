# Deploying RandomMeal to Render

## Step 1: Push Your Code to GitHub

```bash
# Initialize git (if not already done)
git init

# Add all files
git add .

# Commit
git commit -m "Initial commit - RandomMeal Flutter app"

# Create a new repo on GitHub, then:
git remote add origin https://github.com/YOUR_USERNAME/random_meal_app.git
git branch -M main
git push -u origin main
```

## Step 2: Deploy on Render

1. Go to [render.com](https://render.com) and sign up (free)
2. Click **"New +"** → **"Web Service"**
3. Connect your GitHub account
4. Select your `random_meal_app` repository
5. Configure the service:
   - **Name**: `random-meal-app` (or your choice)
   - **Environment**: `Docker`
   - **Region**: Choose closest to you
   - **Branch**: `main`
   - **Instance Type**: `Free`
6. Click **"Create Web Service"**

That's it! Render will:
- Detect your Dockerfile automatically
- Build your Flutter web app
- Deploy it to a public URL like: `https://random-meal-app.onrender.com`

## Step 3: Access Your App

Once deployment completes (5-10 minutes), you'll get a URL like:
```
https://random-meal-app-xxxx.onrender.com
```

Share this URL with anyone! 🎉

## Notes:
- Free tier apps may sleep after 15 minutes of inactivity
- First load after sleeping takes ~30 seconds to wake up
- Perfect for school projects and demos
- No credit card required for free tier

## Troubleshooting:
If build fails, check the Render logs. The Dockerfile should work as-is since it's already configured correctly.
