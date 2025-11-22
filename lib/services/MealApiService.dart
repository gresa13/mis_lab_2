import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/Category.dart';
import '../models/MealDetail.dart';
import '../models/MealSummary.dart';

class MealApiService {
  static const String _baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  static Future<List<Category>> fetchCategories() async {
    final url = Uri.parse('$_baseUrl/categories.php');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List list = data['categories'] ?? [];
      return list.map((e) => Category.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  static Future<List<MealSummary>> fetchMealsByCategory(String category) async {
    final url = Uri.parse('$_baseUrl/filter.php?c=$category');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List list = data['meals'] ?? [];
      return list.map((e) => MealSummary.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load meals');
    }
  }

  static Future<List<MealSummary>> searchMealsInCategory(
    String category,
    String query,
  ) async {
    if (query.trim().isEmpty) {
      return fetchMealsByCategory(category);
    }

    final url = Uri.parse('$_baseUrl/search.php?s=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List? list = data['meals'];

      if (list == null) return [];

      final filtered = list.where(
        (meal) =>
            (meal['strCategory'] ?? '').toString().toLowerCase() ==
            category.toLowerCase(),
      );

      return filtered.map((e) => MealSummary.fromJson(e)).toList();
    } else {
      throw Exception('Failed to search meals');
    }
  }

  static Future<MealDetail> fetchMealDetail(String id) async {
    final url = Uri.parse('$_baseUrl/lookup.php?i=$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List list = data['meals'] ?? [];
      if (list.isEmpty) throw Exception('Meal not found');
      return MealDetail.fromJson(list.first);
    } else {
      throw Exception('Failed to load meal detail');
    }
  }

  static Future<MealDetail> fetchRandomMeal() async {
    final url = Uri.parse('$_baseUrl/random.php');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List list = data['meals'] ?? [];
      if (list.isEmpty) throw Exception('Random meal not found');
      return MealDetail.fromJson(list.first);
    } else {
      throw Exception('Failed to load random meal');
    }
  }
}
