import 'package:flutter/material.dart';
import 'models/grocery_item.dart';
import 'models/meal_plan.dart';
import 'screens/home_screen.dart';
import 'screens/grocery_list_screen.dart';
import 'screens/meal_planner_screen.dart';

/// Main entry point for the RandomMeal app
void main() {
  runApp(const RandomMealApp());
}

/// Root widget with enhanced design and navigation
class RandomMealApp extends StatelessWidget {
  const RandomMealApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RandomMeal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const RandomMealHome(),
    );
  }
}

/// Main navigation screen with bottom tab bar
class RandomMealHome extends StatefulWidget {
  const RandomMealHome({super.key});

  @override
  State<RandomMealHome> createState() => _RandomMealHomeState();
}

class _RandomMealHomeState extends State<RandomMealHome> {
  int _selectedIndex = 0;
  final GroceryList _groceryList = GroceryList();
  final WeeklyMealPlan _mealPlan = WeeklyMealPlan();
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreen(groceryList: _groceryList),
      GroceryListScreen(groceryList: _groceryList),
      MealPlannerScreen(
        mealPlan: _mealPlan,
        groceryList: _groceryList,
        onGetRecipe: (recipe) {
          // Callback for getting recipes from meal planner
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0 
              ? 'RandomMeal' 
              : _selectedIndex == 1
                  ? 'Shopping List'
                  : 'Meal Planner',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: Colors.white,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey[400],
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.restaurant),
            label: 'Recipes',
            tooltip: 'Find Recipes',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              label: _groceryList.items.isEmpty
                  ? null
                  : Text('${_groceryList.items.length}'),
              child: const Icon(Icons.shopping_cart),
            ),
            label: 'Shopping',
            tooltip: 'Shopping List',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.calendar_today),
            label: 'Planner',
            tooltip: 'Meal Planner',
          ),
        ],
      ),
    );
  }
}
