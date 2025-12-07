/// Recipe model class
/// Represents a meal/recipe fetched from TheMealDB API
class Recipe {
  final String id;
  final String name;
  final String category;
  final String area;
  final String instructions;
  final String imageUrl;
  final List<String> ingredients;

  Recipe({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.instructions,
    required this.imageUrl,
    required this.ingredients,
  });

  /// Factory constructor to create a Recipe from JSON
  /// Safely parses the TheMealDB API response
  factory Recipe.fromJson(Map<String, dynamic> json) {
    // Extract ingredients from the API's strIngredient1, strIngredient2, etc. fields
    List<String> ingredients = [];
    
    // TheMealDB API has up to 20 ingredient fields
    for (int i = 1; i <= 20; i++) {
      String? ingredient = json['strIngredient$i'];
      String? measure = json['strMeasure$i'];
      
      // Only add if ingredient exists and is not empty
      if (ingredient != null && ingredient.trim().isNotEmpty) {
        // Combine ingredient with its measure if available
        if (measure != null && measure.trim().isNotEmpty) {
          ingredients.add('$measure $ingredient');
        } else {
          ingredients.add(ingredient);
        }
      }
    }

    return Recipe(
      id: json['idMeal'] ?? '',
      name: json['strMeal'] ?? 'Unknown Meal',
      category: json['strCategory'] ?? 'Unknown',
      area: json['strArea'] ?? 'Unknown',
      instructions: json['strInstructions'] ?? 'No instructions available',
      imageUrl: json['strMealThumb'] ?? '',
      ingredients: ingredients,
    );
  }
}
