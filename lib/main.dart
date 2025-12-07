import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

/// Main entry point for the RandomMeal app
void main() {
  runApp(const RandomMealApp());
}

/// Root widget of the application
class RandomMealApp extends StatelessWidget {
  const RandomMealApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RandomMeal',
      // Remove debug banner
      debugShowCheckedModeBanner: false,
      // App theme
      theme: ThemeData(
        primarySwatch: Colors.orange,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      // Set HomeScreen as the initial route
      home: const HomeScreen(),
    );
  }
}
