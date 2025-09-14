// search_quotes_repository.dart
import 'dart:convert';
import 'package:daily_learning_app/core/constants/app_constants.dart';
import 'package:daily_learning_app/data/model/daily_topic_model.dart';
import 'package:http/http.dart' as http;

class SearchQuotesRepository {
  // Search quotes by keyword (using tag endpoint as fallback)
  Future<List<DailyTopicModel>> searchQuotes(String query) async {
    try {
      // Try searching by tag first
      final tagResponse = await http.get(
        Uri.parse('$baseUrl/quotes/tag/${Uri.encodeComponent(query)}'),
        headers: {'Content-Type': 'application/json'},
      );

      if (tagResponse.statusCode == 200) {
        final List<dynamic> data = jsonDecode(tagResponse.body);
        if (data.isNotEmpty) {
          return data.map((json) => DailyTopicModel.fromJson(json)).toList();
        }
      }

      // If tag search fails, try author search
      final authorResponse = await http.get(
        Uri.parse('$baseUrl/quotes/author/${Uri.encodeComponent(query)}'),
        headers: {'Content-Type': 'application/json'},
      );

      if (authorResponse.statusCode == 200) {
        final List<dynamic> data = jsonDecode(authorResponse.body);
        if (data.isNotEmpty) {
          return data.map((json) => DailyTopicModel.fromJson(json)).toList();
        }
      }

      // If both fail, return empty list
      return [];
    } catch (e) {
      throw Exception('Failed to search quotes: $e');
    }
  }

  // Get search suggestions based on popular keywords
  List<String> getSearchSuggestions() {
    return [
      'inspiration',
      'motivation',
      'success',
      'life',
      'love',
      'wisdom',
      'happiness',
      'leadership',
      'change',
      'dreams',
      'Albert Einstein',
      'Steve Jobs',
      'Maya Angelou',
      'Nelson Mandela',
      'Mahatma Gandhi',
    ];
  }

  // Get recent searches (future enhancement with local storage)
  Future<List<String>> getRecentSearches() async {
    // TODO: Implement local storage for recent searches
    return [];
  }

  // Save search query to recent searches
  Future<void> saveSearchQuery(String query) async {
    // TODO: Implement saving to local storage
  }

  // Clear recent searches
  Future<void> clearRecentSearches() async {
    // TODO: Implement clearing recent searches
  }

  // Advanced search with filters (future enhancement)
  Future<List<DailyTopicModel>> advancedSearch({
    String? query,
    String? author,
    String? category,
    int? minLength,
    int? maxLength,
  }) async {
    // For now, delegate to basic search
    if (query != null) {
      return searchQuotes(query);
    } else if (author != null) {
      return _searchByAuthor(author);
    } else if (category != null) {
      return _searchByCategory(category);
    }
    return [];
  }

  Future<List<DailyTopicModel>> _searchByAuthor(String author) async {
    final response = await http.get(
      Uri.parse('$baseUrl/quotes/author/${Uri.encodeComponent(author)}'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => DailyTopicModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search by author: ${response.statusCode}');
    }
  }

  Future<List<DailyTopicModel>> _searchByCategory(String category) async {
    final response = await http.get(
      Uri.parse('$baseUrl/quotes/tag/${Uri.encodeComponent(category)}'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => DailyTopicModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search by category: ${response.statusCode}');
    }
  }
}