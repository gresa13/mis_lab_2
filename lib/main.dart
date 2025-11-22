import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Screens/CategoriesScreen.dart';

void main() {
  runApp(const MealApp());
}

class MealApp extends StatelessWidget {
  const MealApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TheMealDB Recipes',
      theme: ThemeData(primarySwatch: Colors.orange, useMaterial3: true),
      home: const CategoriesScreen(),
    );
  }
}
