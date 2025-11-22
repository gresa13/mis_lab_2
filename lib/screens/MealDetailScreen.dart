import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/MealDetail.dart';
import '../services/MealApiService.dart';
import '../widgets/RecipeDetailView.dart';

class MealDetailScreen extends StatelessWidget {
  final String mealId;

  const MealDetailScreen({super.key, required this.mealId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recipe')),
      body: FutureBuilder<MealDetail>(
        future: MealApiService.fetchMealDetail(mealId),
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
