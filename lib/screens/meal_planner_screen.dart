import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/meal_plan.dart';
import '../models/recipe.dart';
import '../models/grocery_item.dart';

/// MealPlannerScreen allows users to plan meals for the week
class MealPlannerScreen extends StatefulWidget {
  final WeeklyMealPlan mealPlan;
  final GroceryList groceryList;
  final Function(Recipe) onGetRecipe;

  const MealPlannerScreen({
    super.key,
    required this.mealPlan,
    required this.groceryList,
    required this.onGetRecipe,
  });

  @override
  State<MealPlannerScreen> createState() => _MealPlannerScreenState();
}

class _MealPlannerScreenState extends State<MealPlannerScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _addWeekToGroceryList() {
    final weekIngredients = widget.mealPlan.getAllWeekIngredients();
    widget.groceryList.addItems(weekIngredients);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${weekIngredients.length} ingredients added to grocery list!'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _clearWeekPlan() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Weekly Plan?'),
        content: const Text('This will remove all meals from your weekly plan.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                widget.mealPlan.clearWeek();
              });
              Navigator.pop(context);
            },
            child: const Text('Clear', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalMeals = widget.mealPlan.getTotalMeals();
    final weekIngredients = widget.mealPlan.getAllWeekIngredients();

    return Column(
      children: [
        // Header with summary
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue[400]!, Colors.blue[600]!],
            ),
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Weekly Meal Plan',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$totalMeals meals • ${weekIngredients.length} ingredients',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 32,
                    child: Text(
                      '$totalMeals',
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[600],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Meal plan days
        Expanded(
          child: widget.mealPlan.days.isEmpty
              ? _buildEmptyState()
              : SingleChildScrollView(
                  controller: _scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        ...WeeklyMealPlan.weekDays.map((day) {
                          final dayPlan = widget.mealPlan.days[day]!;
                          return _buildDayCard(day, dayPlan);
                        }),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
        ),

        // Action buttons
        if (totalMeals > 0)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _addWeekToGroceryList,
                    icon: const Icon(Icons.shopping_cart_checkout),
                    label: const Text('Add All to Grocery List'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _clearWeekPlan,
                    icon: const Icon(Icons.delete_sweep),
                    label: const Text('Clear Weekly Plan'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[400],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildDayCard(String day, DayMealPlan dayPlan) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        title: Text(
          day,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          '${dayPlan.meals.length} meal${dayPlan.meals.length != 1 ? 's' : ''} • ${dayPlan.getIngredientsForDay().length} ingredients',
          style: const TextStyle(fontSize: 12),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: dayPlan.meals.isEmpty ? Colors.grey[200] : Colors.blue[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '${dayPlan.meals.length}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: dayPlan.meals.isEmpty ? Colors.grey[600] : Colors.blue[700],
            ),
          ),
        ),
        children: [
          if (dayPlan.meals.isEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Icon(Icons.breakfast_dining, size: 40, color: Colors.grey[300]),
                  const SizedBox(height: 12),
                  Text(
                    'No meals planned',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...dayPlan.meals.asMap().entries.map((entry) {
                    final index = entry.key;
                    final meal = entry.value;
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: index < dayPlan.meals.length - 1 ? 12 : 0,
                      ),
                      child: _buildMealTile(day, meal),
                    );
                  }),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMealTile(String day, Recipe meal) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          // Meal image
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              meal.imageUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 60,
                height: 60,
                color: Colors.grey[300],
                child: const Icon(Icons.restaurant),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Meal info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal.name,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  meal.area,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // Remove button
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              setState(() {
                widget.mealPlan.removeMealFromDay(day, meal);
              });
            },
            color: Colors.red[400],
            iconSize: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today,
              size: 80,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 24),
            Text(
              'No meals planned yet',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Go to Recipes and add meals to your weekly plan!',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
