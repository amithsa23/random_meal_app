# RandomMeal App

A Flutter random recipe generator that fetches delicious meals from TheMealDB API.

![RandomMeal](https://img.shields.io/badge/Flutter-Web%20App-blue)
![License](https://img.shields.io/badge/License-MIT-green)

## 🌟 Features

- 🎲 Random meal generator with one click
- 🖼️ Beautiful recipe cards with images
- 📋 Complete ingredient lists
- 📝 Step-by-step cooking instructions
- 🌍 Meals from around the world
- 📱 Responsive design
- ⚡ Fast and lightweight

## 🚀 Live Demo

[View Live App](https://your-app-name.onrender.com) _(Update this after deployment)_

## 🛠️ Tech Stack

- **Flutter** - UI framework
- **Dart** - Programming language
- **TheMealDB API** - Recipe data source
- **HTTP** - API requests
- **Google Fonts** - Typography
- **Docker** - Containerization
- **Nginx** - Web server

## 📦 Installation

### Prerequisites
- Flutter SDK (3.9.0 or higher)
- Dart SDK
- Git

### Local Development

```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/random_meal_app.git
cd random_meal_app

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Run with Docker

```bash
# Build and run
docker-compose up -d

# Access at http://localhost:8080
```

## 📁 Project Structure

```
lib/
├── main.dart              # App entry point
├── models/
│   └── recipe.dart       # Recipe data model
├── services/
│   └── recipe_service.dart  # API calls
├── screens/
│   └── home_screen.dart  # Main UI
└── widgets/
    └── recipe_card.dart  # Recipe display widget
```

## 🌐 Deployment

This app can be deployed to various platforms:

- **Render**: See [RENDER_DEPLOYMENT.md](RENDER_DEPLOYMENT.md)
- **Docker**: See [DOCKER_DEPLOYMENT.md](DOCKER_DEPLOYMENT.md)
- **Vercel/Netlify**: Build with `flutter build web`

## 🎓 Educational Project

Built for CS2104 Personal Programming Assignment demonstrating:
- RESTful API integration
- State management with StatefulWidget
- JSON parsing
- Error handling
- Responsive UI design
- Docker containerization

## 📄 License

MIT License - Feel free to use this project for learning!

## 🙏 Acknowledgments

- [TheMealDB](https://www.themealdb.com/) for the free recipe API
- Flutter team for the amazing framework

---

Made with ❤️ using Flutter
