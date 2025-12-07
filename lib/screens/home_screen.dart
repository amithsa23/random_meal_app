import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/recipe.dart';
import '../services/recipe_service.dart';
import '../widgets/recipe_card.dart';

/// HomeScreen is the main screen of the app
/// Displays a button to fetch random meals and shows the recipe
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Instance of RecipeService to make API calls
  final RecipeService _recipeService = RecipeService();

  // State variables
  Recipe? _currentRecipe; // Currently displayed recipe
  bool _isLoading = false; // Loading state
  String? _errorMessage; // Error message if API call fails

  /// Fetches a random meal from the API
  Future<void> _fetchRandomMeal() async {
    // Clear any previous error and set loading state
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Make API call
      final recipe = await _recipeService.getRandomMeal();

      // Update state with the new recipe
      setState(() {
        _currentRecipe = recipe;
        _isLoading = false;
      });
    } catch (e) {
      // Handle errors
      setState(() {
        _errorMessage = 'Failed to load recipe. Please try again.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'RandomMeal',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Main content area
            if (_isLoading)
              // Loading state
              _buildLoadingState()
            else if (_errorMessage != null)
              // Error state
              _buildErrorState()
            else if (_currentRecipe != null)
              // Recipe display state
              RecipeCard(recipe: _currentRecipe!)
            else
              // Initial/empty state
              _buildEmptyState(),

            const SizedBox(height: 20),

            // "Get Random Meal" button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: _isLoading ? null : _fetchRandomMeal,
                  icon: const Icon(Icons.restaurant),
                  label: Text(
                    _currentRecipe == null
                        ? 'Get Random Meal'
                        : 'Get Another Meal',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  /// Widget for loading state
  Widget _buildLoadingState() {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          const CircularProgressIndicator(
            color: Colors.orange,
          ),
          const SizedBox(height: 20),
          Text(
            'Fetching a delicious recipe...',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  /// Widget for error state
  Widget _buildErrorState() {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Icon(
            Icons.error_outline,
            size: 80,
            color: Colors.red[300],
          ),
          const SizedBox(height: 20),
          Text(
            _errorMessage!,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _fetchRandomMeal,
            icon: const Icon(Icons.refresh),
            label: const Text('Try Again'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Widget for empty/initial state
  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Icon(
            Icons.restaurant_menu,
            size: 100,
            color: Colors.orange[200],
          ),
          const SizedBox(height: 24),
          Text(
            'Welcome to RandomMeal!',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'Discover delicious recipes from around the world.\nTap the button below to get started!',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
