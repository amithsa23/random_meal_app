# RandomMeal App

A Flutter random recipe generator that fetches delicious meals from TheMealDB API.

![RandomMeal](https://img.shields.io/badge/Flutter-Web%20App-blue)
![License](https://img.shields.io/badge/License-MIT-green)

## 📹 Video Demo

Watch the full app demonstration: [RandomMeal App Demo](https://youtu.be/8Wzs3epNPd8)

## 🌟 Features

- 🎲 **Random Meal Generator** - Discover new recipes with one click
- 🍽️ **Category Filtering** - Browse by meal type (Breakfast, Lunch, Dessert, etc.)
- 📋 **Complete Ingredients** - See full ingredient lists with measurements
- 📝 **Cooking Instructions** - Step-by-step preparation guide
- ❤️ **Favorites** - Save your favorite meals (session-persistent)
- 📅 **Weekly Meal Planner** - Plan meals throughout the week
- 🛒 **Grocery List** - Add ingredients to your shopping list
- 📊 **Master Grocery List** - Compile all ingredients from weekly plan
- 🌍 **Meals from Around the World** - Explore international cuisines
- 📱 **Responsive Design** - Beautiful UI on all screen sizes
- ⚡ **Fast & Lightweight** - Instant recipe loading

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
├── main.dart                          # App entry point with navigation
├── models/
│   ├── recipe.dart                   # Recipe data model
│   ├── grocery_item.dart             # Shopping list models
│   └── meal_plan.dart                # Weekly meal planning
├── services/
│   └── recipe_service.dart           # TheMealDB API calls
├── screens/
│   ├── home_screen.dart              # Recipe discovery
│   ├── grocery_list_screen.dart      # Shopping list manager
│   └── meal_planner_screen.dart      # Weekly meal planner
└── widgets/
    └── recipe_card.dart              # Reusable recipe display
```

## 🎯 How to Use

### 1. **Find Recipes**
   - Browse Random recipes or select a category
   - View full ingredient lists and instructions
   - Add to favorites with the heart button

### 2. **Plan Your Week**
   - Click "Add to Plan" to add recipes to specific days
   - View all meals planned for each day
   - Remove meals as needed

### 3. **Build Grocery List**
   - Add individual recipe ingredients with "Add to List"
   - Or compile entire week with "Add All to Grocery List"
   - Check off items as you shop
   - Clear completed items

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
