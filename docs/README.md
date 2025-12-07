# Documentation

This directory contains supporting materials for the RandomMeal app project.

## Contents

- **Screenshots**: Visual documentation of the app interface
- **Architecture Diagrams**: System design and data flow diagrams
- **API Documentation**: TheMealDB API integration details
- **Deployment Guides**: See root directory for DOCKER_DEPLOYMENT.md and RENDER_DEPLOYMENT.md

## Screenshots

### Home Screen - Recipe Discovery
![Home Screen](screenshots/home_screen.png)
- Category filtering
- Random recipe generation
- Recipe details with ingredients and instructions

### Meal Planner Screen
![Meal Planner](screenshots/planner_screen.png)
- 7-day weekly calendar
- Meal assignment per day
- Weekly ingredient summary

### Shopping List Screen
![Shopping List](screenshots/shopping_screen.png)
- Organized grocery list
- Check-off functionality
- Master list from weekly plan

## API Integration

### TheMealDB Endpoints Used

1. **Random Meal**: `GET /random.php`
   - Returns single random meal with full details

2. **Filter by Category**: `GET /filter.php?c={category}`
   - Returns meals in specified category

3. **Categories List**: `GET /categories.php`
   - Returns all available meal categories

4. **Meal Details**: `GET /lookup.php?i={id}`
   - Returns complete meal information by ID

## Architecture Overview

```
User Interface (Flutter Widgets)
         ↓
    Screens Layer
         ↓
   Services Layer (API Calls)
         ↓
    Models Layer (Data)
         ↓
  State Management (setState)
```

## For More Information

See the main [README.md](../README.md) in the project root.
