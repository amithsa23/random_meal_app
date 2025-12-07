# RandomMeal - Flutter Random Recipe Generator

A simple Flutter app that fetches random meal recipes from TheMealDB API and displays them with beautiful UI.

## Features

✅ Fetch random meals from TheMealDB API  
✅ Display meal name, image, category, area, and ingredients  
✅ Clean loading and error states  
✅ Responsive UI with scrollable content  
✅ Beautiful typography using Google Fonts  
✅ Simple state management with StatefulWidget  

## Project Structure

```
lib/
├── main.dart                 # App entry point and MaterialApp setup
├── models/
│   └── recipe.dart          # Recipe model with JSON parsing
├── services/
│   └── recipe_service.dart  # API calls to TheMealDB
├── screens/
│   └── home_screen.dart     # Main screen with state management
└── widgets/
    └── recipe_card.dart     # Reusable recipe display widget
```

## How to Run

1. Make sure you have Flutter installed and configured
2. Open terminal in the project directory
3. Run: `flutter pub get` (already done)
4. Run: `flutter run`

## How It Works

1. **Recipe Model** (`recipe.dart`): Parses JSON from TheMealDB API, extracting ingredients from `strIngredient1` through `strIngredient20` fields
2. **RecipeService** (`recipe_service.dart`): Makes HTTP GET requests to the random meal endpoint
3. **HomeScreen** (`home_screen.dart`): Manages app state (loading/error/success) using `setState()`
4. **RecipeCard** (`recipe_card.dart`): Displays recipe in a beautiful card layout

## API Used

[TheMealDB API](https://www.themealdb.com/api.php)  
Endpoint: `https://www.themealdb.com/api/json/v1/1/random.php`

## Dependencies

- `http: ^1.2.0` - For making HTTP requests
- `google_fonts: ^6.1.0` - For beautiful typography

## Key Concepts Demonstrated

- **State Management**: Using StatefulWidget and setState()
- **HTTP Requests**: Making API calls with the http package
- **JSON Parsing**: Converting API responses to Dart objects
- **Error Handling**: Try-catch blocks and error states
- **Async/Await**: Handling asynchronous operations
- **Widget Composition**: Building reusable widgets
- **Material Design**: Using Material 3 components

## Next Steps (Optional Enhancements)

- [ ] Add favorites feature with local storage
- [ ] Implement dark mode
- [ ] Add search by category or area
- [ ] Add animations and transitions
- [ ] Save favorite recipes to a list

---

Built for CS2104 Personal Programming Assignment
