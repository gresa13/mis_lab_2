import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/MealDetail.dart';
import '../services/MealApiService.dart';
import '../widgets/RecipeDetailView.dart';

class RandomMealScreen extends StatelessWidget {
  const RandomMealScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Random Recipe of the Day')),
      body: FutureBuilder<MealDetail>(
        future: MealApiService.fetchRandomMeal(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final meal = snapshot.data!;
          return RecipeDetailView(meal: meal);
        },
      ),
    );
  }
}
