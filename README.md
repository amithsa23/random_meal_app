# RandomMeal App

A comprehensive Flutter application for recipe discovery, weekly meal planning, and smart grocery list management.

![RandomMeal](https://img.shields.io/badge/Flutter-Web%20App-blue)
![License](https://img.shields.io/badge/License-MIT-green)

---

## 📹 Video Demonstration

**Watch the complete app demo**: [RandomMeal App Demo on YouTube](https://youtu.be/8Wzs3epNPd8)

---

## 📖 Project Overview and Purpose

**RandomMeal** is a full-stack mobile and web application built with Flutter that solves the common problem of meal planning and grocery shopping organization. The app allows users to:

- **Discover Recipes**: Browse random meals or filter by category from TheMealDB API
- **Plan Weekly Meals**: Create a 7-day meal calendar with multiple meals per day
- **Generate Smart Shopping Lists**: Automatically compile ingredients from your meal plan with intelligent deduplication
- **Manage Favorites**: Save preferred recipes for quick access

**Problem Solved**: Instead of manually planning meals, searching for recipes across multiple sources, and creating shopping lists by hand, RandomMeal provides an integrated solution that streamlines the entire process from recipe discovery to grocery shopping.

**Target Users**: Home cooks, meal prep enthusiasts, busy professionals, and anyone looking to organize their weekly meals efficiently.

---

## 🚀 Live Demo

**Production URL**: [https://random-meal-app-pglh.onrender.com](https://random-meal-app-pglh.onrender.com)

---

## 🌟 Key Features

### Recipe Discovery
- 🎲 **Random Meal Generator** - One-click recipe discovery
- 🍽️ **Category Filtering** - Browse by Breakfast, Lunch, Dessert, Seafood, etc.
- 🖼️ **Rich Recipe Details** - High-quality images, ingredients with measurements, step-by-step instructions
- ❤️ **Favorites System** - Save and manage favorite recipes (session-persistent)
- 🌍 **International Cuisines** - Explore meals from around the world

### Weekly Meal Planner
- 📅 **7-Day Calendar** - Plan meals for Monday through Sunday
- ➕ **Easy Meal Assignment** - Add recipes to specific days via bottom sheet selector
- 📊 **Weekly Overview** - View total meals and ingredient counts
- 🗑️ **Flexible Management** - Remove individual meals or clear entire days/weeks

### Smart Grocery Management
- 🛒 **Individual Recipe Lists** - Add ingredients from single recipes
- 📋 **Master Weekly List** - Compile all ingredients from entire week's meal plan
- ✅ **Shopping Assistant** - Check off items as you shop
- 🔄 **Smart Deduplication** - Eliminates duplicate ingredients across multiple recipes
- 📱 **Organized Display** - Separate "To Buy" and "Purchased" sections

---

## 📦 Installation and Setup Instructions

### Prerequisites

Ensure you have the following installed:
- **Flutter SDK**: Version 3.9.0 or higher ([Download](https://flutter.dev/docs/get-started/install))
- **Dart SDK**: Included with Flutter
- **Git**: For cloning the repository
- **Code Editor**: VS Code or Android Studio (recommended)
- **Platform-Specific Requirements**:
  - macOS: Xcode (for iOS/macOS development)
  - Windows: Visual Studio (for Windows development)
  - Linux: Standard development tools

### Step 1: Clone the Repository

```bash
git clone https://github.com/amithsa23/random_meal_app.git
cd random_meal_app
```

### Step 2: Install Dependencies

```bash
flutter pub get
```

This will download all required packages specified in `pubspec.yaml`:
- `http: ^1.2.0` - For API requests
- `google_fonts: ^6.1.0` - For typography

### Step 3: Verify Installation

```bash
# Check Flutter installation
flutter doctor

# Verify all dependencies are installed
flutter pub get
```

### Step 4: Configure Platform (Optional)

For **macOS development**, network permissions are already configured in:
- `macos/Runner/DebugProfile.entitlements`
- `macos/Runner/Release.entitlements`

For other platforms, no additional configuration is needed.

---

## ▶️ How to Run the Program and Reproduce Results

### Running on Different Platforms

#### macOS Application
```bash
flutter run -d macos
```

#### Web Application
```bash
flutter run -d chrome
```

#### iOS Simulator (macOS only)
```bash
flutter run -d ios
```

#### Android Emulator
```bash
flutter run -d android
```

### Building for Production

#### Web Build
```bash
flutter build web
# Output: build/web/
```

#### macOS Build
```bash
flutter build macos --release
# Output: build/macos/Build/Products/Release/
```

#### Docker Build
```bash
# Build the Docker image
docker build -t random-meal-app .

# Run the container
docker-compose up -d

# Access at http://localhost:8080
```

### Expected Results

When the app launches, you should see:
1. **Recipes Tab**: Orange-themed recipe discovery screen with category filters
2. **Shopping Tab**: Green-themed grocery list (initially empty)
3. **Planner Tab**: Blue-themed weekly calendar (initially empty)

**Test the workflow**:
1. Click "Get Recipe" → A random meal appears with image and details
2. Click "Add to Plan" → Select a day → Meal added to calendar
3. Switch to "Planner" tab → See your meal in the weekly view
4. Click "Add All to Grocery List" → All ingredients compiled
5. Switch to "Shopping" tab → See the deduplicated ingredient list

---

## 🛠️ Technologies and Libraries Used

### Core Framework
- **Flutter 3.9.0+** - Cross-platform UI framework
- **Dart** - Programming language with null safety

### Dependencies
| Package | Version | Purpose |
|---------|---------|---------|
| `http` | ^1.2.0 | HTTP client for REST API calls |
| `google_fonts` | ^6.1.0 | Custom typography (Poppins font) |

### External APIs
- **TheMealDB API** - Free recipe database
  - Base URL: `https://www.themealdb.com/api/json/v1/1/`
  - Endpoints: `/random.php`, `/filter.php`, `/categories.php`, `/lookup.php`

### Development Tools
- **Docker** - Containerization and deployment
- **Nginx** - Web server for production
- **Git** - Version control
- **GitHub** - Code hosting and collaboration

### Platform SDKs
- **macOS SDK** - For desktop application
- **Web SDK** - For browser deployment
- **iOS SDK** - For iPhone/iPad (optional)
- **Android SDK** - For Android devices (optional)

---

## 👤 Author(s) and Contribution Summary

**Author**: Amith Saligram  
**Email**: amithsa@vt.edu  
**GitHub**: [@amithsa23](https://github.com/amithsa23)  
**Course**: CS2104 - Personal Programming Assignment  
**Semester**: Fall 2024

### Contribution Summary

**Solo Developer** - All features, architecture, and deployment completed individually.

#### Phase 1: Foundation (Weeks 1-2)
- Set up Flutter project structure
- Integrated TheMealDB REST API
- Implemented Recipe model with JSON parsing
- Created RecipeService for API calls

#### Phase 2: Core Features (Weeks 3-4)
- Built HomeScreen with category filtering
- Designed RecipeCard widget with Material Design 3
- Implemented favorites system
- Added grocery list functionality with GroceryList model

#### Phase 3: Advanced Features (Week 5)
- Developed weekly meal planner architecture
- Created DayMealPlan and WeeklyMealPlan models
- Built MealPlannerScreen with expandable day cards
- Implemented smart ingredient deduplication algorithm

#### Phase 4: Polish & Deployment (Week 6)
- Refined UI/UX with bottom sheets and snackbars
- Fixed macOS network permissions
- Created Docker multi-stage build configuration
- Deployed to Render.com with CI/CD
- Created comprehensive documentation

**Total Development Time**: ~16-20 hours  
**Lines of Code**: ~1,200+ (Dart)  
**Files Created**: 8 Dart files, 3 markdown docs, Docker configs

---

## 📁 Repository Structure

```
random_meal_app/
├── lib/                          # Source code (organized by component)
│   ├── main.dart                # App initialization and navigation
│   ├── models/                  # Data models
│   │   ├── recipe.dart         # Recipe model with JSON parsing
│   │   ├── grocery_item.dart   # Grocery list management
│   │   └── meal_plan.dart      # Weekly meal planning models
│   ├── services/               # API integration layer
│   │   └── recipe_service.dart # TheMealDB API client
│   ├── screens/                # UI screens
│   │   ├── home_screen.dart   # Recipe discovery screen
│   │   ├── grocery_list_screen.dart  # Shopping list UI
│   │   └── meal_planner_screen.dart  # Weekly planner UI
│   └── widgets/                # Reusable components
│       └── recipe_card.dart    # Recipe display widget
├── test/                        # Test scripts and verification
│   └── widget_test.dart        # Widget unit tests
├── docs/                        # Supporting documentation
│   └── (Screenshots and additional docs)
├── data/                        # Configuration files
│   └── (No local data files - all data from API)
├── report/                      # Final report document
│   └── (Project report materials)
├── Dockerfile                   # Multi-stage Docker build
├── docker-compose.yml          # Local Docker development
├── pubspec.yaml                # Dart dependencies
├── README.md                   # This file
├── DOCKER_DEPLOYMENT.md        # Docker deployment guide
└── RENDER_DEPLOYMENT.md        # Render.com deployment guide
```

---

## 🎯 Usage Guide

### Workflow 1: Quick Recipe Discovery
1. Open app → Land on **Recipes** tab
2. Click **"Get Recipe"** → Random meal appears
3. Browse ingredients and instructions
4. Click **"Add to List"** → Ingredients added to shopping list
5. Switch to **Shopping** tab → Check off items while shopping

### Workflow 2: Weekly Meal Planning
1. **Recipes** tab → Select category (e.g., "Dessert")
2. Click **"Get Recipe"** → Find a dessert you like
3. Click **"Add to Plan"** → Select "Monday"
4. Repeat for other days of the week
5. Switch to **Planner** tab → View weekly calendar
6. Click **"Add All to Grocery List"** → Master list compiled
7. Switch to **Shopping** tab → Shop for the entire week

### Workflow 3: Favorites Management
1. Find a recipe you love → Click **heart icon**
2. Recipe saved to favorites (persists during session)
3. Add favorite recipes to your meal plan
4. Generate shopping lists from favorites

---

## 🔧 Troubleshooting

### Common Issues

**Issue**: "No internet connection" error  
**Solution**: Check network connection; on macOS, ensure entitlements are set (already configured)

**Issue**: Categories not loading  
**Solution**: TheMealDB API may be rate-limited; wait 1-2 minutes and refresh

**Issue**: Images not displaying  
**Solution**: Verify internet connection; images are loaded from TheMealDB CDN

**Issue**: Hot reload not working  
**Solution**: Restart the app with `flutter run` (full restart)

---

## 🚀 Deployment Information

### Production Deployment

**Platform**: Render.com (Static Site)  
**URL**: https://random-meal-app-pglh.onrender.com  
**Build Command**: `flutter build web`  
**Publish Directory**: `build/web`  
**Auto-Deploy**: Enabled via GitHub integration

### Local Docker Deployment

```bash
# Build image
docker build -t random-meal-app .

# Run container
docker-compose up -d

# Access
open http://localhost:8080
```

---

## 📄 License

MIT License - Free to use for educational and personal projects.

---

## 🙏 Acknowledgments

- **TheMealDB** - Free recipe API ([www.themealdb.com](https://www.themealdb.com/))
- **Flutter Team** - Excellent framework and documentation
- **CS2104 Course Staff** - Guidance and project structure
- **Render.com** - Free hosting for static sites

---

## 📞 Contact

For questions or feedback:
- **Email**: amithsa@vt.edu
- **GitHub Issues**: [Report a bug](https://github.com/amithsa23/random_meal_app/issues)
- **GitHub Repository**: [View Source Code](https://github.com/amithsa23/random_meal_app)

---

**Last Updated**: December 6, 2024  
**Version**: 1.0.0  
**Status**: ✅ Production Ready

---

Made with ❤️ using Flutter
