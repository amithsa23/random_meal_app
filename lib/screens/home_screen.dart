import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/recipe.dart';
import '../models/grocery_item.dart';
import '../services/recipe_service.dart';
import '../widgets/recipe_card.dart';

/// HomeScreen is the main screen showing random meals with category filtering
class HomeScreen extends StatefulWidget {
  final GroceryList groceryList;

  const HomeScreen({super.key, required this.groceryList});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RecipeService _recipeService = RecipeService();

  Recipe? _currentRecipe;
  bool _isLoading = false;
  String? _errorMessage;
  List<String> _categories = [];
  String _selectedCategory = 'Random';
  bool _showFavoritesOnly = false;
  List<String> _favorites = [];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  /// Load available meal categories
  Future<void> _loadCategories() async {
    try {
      final categories = await _recipeService.getCategories();
      setState(() {
        _categories = ['Random', ...categories];
      });
    } catch (e) {
      // Categories will default to just "Random"
    }
  }

  /// Fetch a meal (random or by category)
  Future<void> _fetchMeal() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      Recipe recipe;
      if (_selectedCategory == 'Random') {
        recipe = await _recipeService.getRandomMeal();
      } else {
        recipe = await _recipeService.getMealByCategory(_selectedCategory);
      }

      setState(() {
        _currentRecipe = recipe;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load recipe. Please try again.';
        _isLoading = false;
      });
    }
  }

  /// Toggle favorite status
  void _toggleFavorite() {
    if (_currentRecipe == null) return;

    setState(() {
      if (_favorites.contains(_currentRecipe!.id)) {
        _favorites.remove(_currentRecipe!.id);
      } else {
        _favorites.add(_currentRecipe!.id);
      }
    });
  }

  /// Add ingredients to grocery list
  void _addToGroceryList() {
    if (_currentRecipe == null) return;

    widget.groceryList.addItems(_currentRecipe!.ingredients);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${_currentRecipe!.ingredients.length} ingredients added to grocery list!'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 16),

          // Category Selector
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose Category',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _categories.isEmpty
                        ? [_buildCategoryChip('Random')]
                        : _categories.map((category) => _buildCategoryChip(category)).toList(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Main content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                if (_isLoading)
                  _buildLoadingState()
                else if (_errorMessage != null)
                  _buildErrorState()
                else if (_currentRecipe != null)
                  Column(
                    children: [
                      RecipeCard(
                        recipe: _currentRecipe!,
                        isFavorited: _favorites.contains(_currentRecipe!.id),
                        onFavoritePressed: _toggleFavorite,
                      ),
                      const SizedBox(height: 16),
                      // Action buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _addToGroceryList,
                              icon: const Icon(Icons.shopping_cart),
                              label: const Text('Add to List'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton.icon(
                            onPressed: _toggleFavorite,
                            icon: Icon(
                              _favorites.contains(_currentRecipe!.id)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                            ),
                            label: const Text(''),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _favorites.contains(_currentRecipe!.id)
                                  ? Colors.red
                                  : Colors.grey[300],
                              foregroundColor: _favorites.contains(_currentRecipe!.id)
                                  ? Colors.white
                                  : Colors.grey[700],
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                else
                  _buildEmptyState(),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Get Meal Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : _fetchMeal,
                icon: const Icon(Icons.restaurant),
                label: Text(
                  _currentRecipe == null ? 'Get Recipe' : 'Get Another',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.orange[200],
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
    );
  }

  /// Build category filter chip
  Widget _buildCategoryChip(String category) {
    final isSelected = _selectedCategory == category;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(
          category,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.orange[800],
          ),
        ),
        onSelected: (selected) {
          setState(() {
            _selectedCategory = category;
          });
        },
        backgroundColor: isSelected ? Colors.orange : Colors.orange[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          const CircularProgressIndicator(
            color: Colors.orange,
            strokeWidth: 3,
          ),
          const SizedBox(height: 20),
          Text(
            'Finding a delicious recipe...',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

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
            onPressed: _fetchMeal,
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
            'Pick a category or go random,\nthen discover amazing recipes!',
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
