import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';

/// RecipeService handles all API calls to TheMealDB
/// Fetches random meals, meals by category, and category list
class RecipeService {
  static const String _baseUrl = 'https://www.themealdb.com/api/json/v1/1';
  static const String _randomMealEndpoint = '$_baseUrl/random.php';
  static const String _categoriesEndpoint = '$_baseUrl/categories.php';

  /// Fetches a random meal from TheMealDB API
  Future<Recipe> getRandomMeal() async {
    try {
      final response = await http.get(Uri.parse(_randomMealEndpoint));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['meals'] != null && data['meals'].isNotEmpty) {
          final mealJson = data['meals'][0];
          return Recipe.fromJson(mealJson);
        } else {
          throw Exception('No meal data found in response');
        }
      } else {
        throw Exception('Failed to load recipe. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching random meal: $e');
    }
  }

  /// Fetches meals by category
  /// Categories: Breakfast, Lunch, Dinner, Dessert, Vegan, Vegetarian, etc.
  Future<Recipe> getMealByCategory(String category) async {
    try {
      final url = '$_baseUrl/filter.php?c=$category';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['meals'] != null && data['meals'].isNotEmpty) {
          // Get a random meal from the category
          final meals = data['meals'] as List;
          final randomMeal = meals[(meals.length * DateTime.now().millisecondsSinceEpoch).toInt() % meals.length];
          
          // Fetch full meal details
          return await _getFullMealDetails(randomMeal['idMeal']);
        } else {
          throw Exception('No meals found in this category');
        }
      } else {
        throw Exception('Failed to load meals. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching meals by category: $e');
    }
  }

  /// Get full meal details by meal ID
  Future<Recipe> _getFullMealDetails(String mealId) async {
    try {
      final url = '$_baseUrl/lookup.php?i=$mealId';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['meals'] != null && data['meals'].isNotEmpty) {
          return Recipe.fromJson(data['meals'][0]);
        } else {
          throw Exception('Meal not found');
        }
      } else {
        throw Exception('Failed to load meal details');
      }
    } catch (e) {
      throw Exception('Error fetching meal details: $e');
    }
  }

  /// Fetches all available categories
  Future<List<String>> getCategories() async {
    try {
      final response = await http.get(Uri.parse(_categoriesEndpoint));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['categories'] != null) {
          final categories = (data['categories'] as List)
              .map((cat) => cat['strCategory'] as String)
              .toList();
          return categories;
        } else {
          throw Exception('No categories found');
        }
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }
}
