import 'recipe.dart';

/// MealPlan represents meals planned for a specific day
class DayMealPlan {
  final String day;
  final List<Recipe> meals;

  DayMealPlan({
    required this.day,
    this.meals = const [],
  });

  /// Add a meal to this day
  DayMealPlan addMeal(Recipe meal) {
    final updatedMeals = List<Recipe>.from(meals);
    updatedMeals.add(meal);
    return DayMealPlan(day: day, meals: updatedMeals);
  }

  /// Remove a meal from this day
  DayMealPlan removeMeal(Recipe meal) {
    final updatedMeals = List<Recipe>.from(meals);
    updatedMeals.removeWhere((m) => m.id == meal.id);
    return DayMealPlan(day: day, meals: updatedMeals);
  }

  /// Get all ingredients for this day
  List<String> getIngredientsForDay() {
    final ingredients = <String>[];
    for (var meal in meals) {
      ingredients.addAll(meal.ingredients);
    }
    return ingredients;
  }
}

/// WeeklyMealPlan manages meals for the entire week
class WeeklyMealPlan {
  final Map<String, DayMealPlan> days;

  static const List<String> weekDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  WeeklyMealPlan({Map<String, DayMealPlan>? initialDays})
      : days = initialDays ??
            {
              for (var day in weekDays)
                day: DayMealPlan(
                  day: day,
                  meals: [],
                )
            };

  /// Add a meal to a specific day
  void addMealToDay(String day, Recipe meal) {
    if (days.containsKey(day)) {
      days[day] = days[day]!.addMeal(meal);
    }
  }

  /// Remove a meal from a specific day
  void removeMealFromDay(String day, Recipe meal) {
    if (days.containsKey(day)) {
      days[day] = days[day]!.removeMeal(meal);
    }
  }

  /// Get all unique ingredients for the entire week
  List<String> getAllWeekIngredients() {
    final allIngredients = <String>[];
    for (var dayPlan in days.values) {
      allIngredients.addAll(dayPlan.getIngredientsForDay());
    }

    // Remove duplicates while preserving order
    final uniqueIngredients = <String>[];
    final seen = <String>{};
    for (var ingredient in allIngredients) {
      final normalized = ingredient.toLowerCase().trim();
      if (!seen.contains(normalized)) {
        seen.add(normalized);
        uniqueIngredients.add(ingredient);
      }
    }

    return uniqueIngredients;
  }

  /// Get total meals planned for the week
  int getTotalMeals() {
    return days.values.fold(0, (sum, day) => sum + day.meals.length);
  }

  /// Get meals for a specific day
  List<Recipe> getMealsForDay(String day) {
    return days[day]?.meals ?? [];
  }

  /// Clear all meals for a specific day
  void clearDay(String day) {
    if (days.containsKey(day)) {
      days[day] = DayMealPlan(day: day, meals: []);
    }
  }

  /// Clear entire weekly plan
  void clearWeek() {
    for (var day in weekDays) {
      clearDay(day);
    }
  }
}
