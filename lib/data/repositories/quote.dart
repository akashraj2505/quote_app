import 'dart:convert';
import 'package:daily_learning_app/core/constants/app_constants.dart';
import 'package:daily_learning_app/data/model/daily_topic_model.dart';
import 'package:http/http.dart' as http;

class CategoryQuotesRepository {
  // Existing method for today's quote
  Future<DailyTopicModel> getTodaysQuote() async {
    final response = await http.get(
      Uri.parse('$baseUrl/quotes/today'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        return DailyTopicModel.fromJson(data.first);
      }
      throw Exception('No quote found');
    } else {
      throw Exception('Failed to fetch today\'s quote: ${response.statusCode}');
    }
  }

  // New method for random quote
  Future<DailyTopicModel> getRandomQuote() async {
    final response = await http.get(
      Uri.parse('$baseUrl/quotes/random'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        return DailyTopicModel.fromJson(data.first);
      }
      throw Exception('No random quote found');
    } else {
      throw Exception('Failed to fetch random quote: ${response.statusCode}');
    }
  }

  // New method for quotes by tag/category
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

  // New method for quotes by author
  Future<List<DailyTopicModel>> getQuotesByAuthor(String author) async {
    // Encode author name for URL
    final encodedAuthor = Uri.encodeComponent(author);
    final response = await http.get(
      Uri.parse('$baseUrl/quotes/author/$encodedAuthor'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => DailyTopicModel.fromJson(json)).toList();
    } else {
      throw Exception(
          'Failed to fetch quotes by author: ${response.statusCode}');
    }
  }

  // New method for batch quotes (useful for previous topics section)
  Future<List<DailyTopicModel>> getBatchQuotes() async {
    final response = await http.get(
      Uri.parse('$baseUrl/quotes/batch'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => DailyTopicModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch batch quotes: ${response.statusCode}');
    }
  }

  // New method to get all available authors
  Future<List<String>> getAllAuthors() async {
    final response = await http.get(
      Uri.parse('$baseUrl/authors'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      // Assuming the API returns a list of author names
      return data.cast<String>();
    } else {
      throw Exception('Failed to fetch authors: ${response.statusCode}');
    }
  }

  // New method to get all available keywords/tags
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
}
