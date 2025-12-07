# Data Directory

This directory is reserved for configuration files and datasets used by the RandomMeal app.

## Current Status

**No local data files are required** for this application.

All recipe data is fetched in real-time from the **TheMealDB API**:
- **Base URL**: `https://www.themealdb.com/api/json/v1/1/`
- **Data Format**: JSON
- **Authentication**: None required (free public API)

## API Data Structure

### Recipe Object Example
```json
{
  "idMeal": "52772",
  "strMeal": "Teriyaki Chicken Casserole",
  "strCategory": "Chicken",
  "strArea": "Japanese",
  "strInstructions": "Preheat oven to 350°F...",
  "strMealThumb": "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg",
  "strIngredient1": "soy sauce",
  "strMeasure1": "3/4 cup",
  "strIngredient2": "water",
  "strMeasure2": "1/2 cup",
  ...
}
```

### Category Object Example
```json
{
  "idCategory": "1",
  "strCategory": "Beef",
  "strCategoryThumb": "https://www.themealdb.com/images/category/beef.png",
  "strCategoryDescription": "Beef is the culinary name..."
}
```

## Future Data Files

If the app is extended to include offline functionality or caching, this directory would contain:

- `cached_recipes.json` - Locally cached recipes for offline access
- `user_favorites.json` - Persistent favorite recipes
- `meal_plans.json` - Saved weekly meal plans
- `config.json` - App configuration settings

## Configuration

Current app configuration is managed through:
- `pubspec.yaml` - Dart package dependencies
- Environment variables (for deployment)
- Platform-specific entitlements (macOS network permissions)

## Notes

- All data fetching is handled by `lib/services/recipe_service.dart`
- No authentication tokens or API keys required
- TheMealDB is a free, open-source recipe database
- API rate limits: No official limits, but use responsibly
