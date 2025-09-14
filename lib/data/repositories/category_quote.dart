// category_quotes_repository.dart
import 'dart:convert';
import 'package:daily_learning_app/core/constants/app_constants.dart';
import 'package:daily_learning_app/data/model/daily_topic_model.dart';
import 'package:http/http.dart' as http;

class CategoryQuoteRepository {
  // Get quotes by tag/category
  Future<List<DailyTopicModel>> getQuotesByTag(String tag) async {
    final response = await http.get(
      Uri.parse('$baseUrl/quotes/tag/$tag'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => DailyTopicModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch quotes by tag: ${response.statusCode}');
    }
  }

  // Get all available keywords/tags
  Future<List<String>> getAllKeywords() async {
    final response = await http.get(
      Uri.parse('$baseUrl/keywords'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      // Assuming the API returns a list of keywords
      return data.cast<String>();
    } else {
      throw Exception('Failed to fetch keywords: ${response.statusCode}');
    }
  }

  // Get available categories (predefined list as fallback)
  List<Map<String, String>> getDefaultCategories() {
    return [
      {'name': 'Inspiration', 'tag': 'inspiration'},
      {'name': 'Motivation', 'tag': 'motivation'},
      {'name': 'Wisdom', 'tag': 'wisdom'},
      {'name': 'Success', 'tag': 'success'},
      {'name': 'Life', 'tag': 'life'},
      {'name': 'Love', 'tag': 'love'},
      {'name': 'Happiness', 'tag': 'happiness'},
      {'name': 'Leadership', 'tag': 'leadership'},
      {'name': 'Change', 'tag': 'change'},
      {'name': 'Dreams', 'tag': 'dreams'},
    ];
  }
}