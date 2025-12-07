import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';

/// RecipeService handles all API calls to TheMealDB
/// Fetches random meals and parses JSON responses
class RecipeService {
  // TheMealDB random meal API endpoint
  static const String _baseUrl = 'https://www.themealdb.com/api/json/v1/1';
  static const String _randomMealEndpoint = '$_baseUrl/random.php';

  /// Fetches a random meal from TheMealDB API
  /// Returns a Recipe object or throws an error
  Future<Recipe> getRandomMeal() async {
    try {
      // Make GET request to the API
      final response = await http.get(Uri.parse(_randomMealEndpoint));

      // Check if request was successful
      if (response.statusCode == 200) {
        // Parse JSON response
        final Map<String, dynamic> data = json.decode(response.body);
        
        // The API returns meals in a 'meals' array
        if (data['meals'] != null && data['meals'].isNotEmpty) {
          // Get the first meal from the array
          final mealJson = data['meals'][0];
          
          // Convert JSON to Recipe object
          return Recipe.fromJson(mealJson);
        } else {
          throw Exception('No meal data found in response');
        }
      } else {
        // Handle HTTP errors
        throw Exception('Failed to load recipe. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Re-throw the error with context
      throw Exception('Error fetching random meal: $e');
    }
  }
}
