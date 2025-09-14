// author_quotes_repository.dart
import 'dart:convert';
import 'package:daily_learning_app/core/constants/app_constants.dart';
import 'package:daily_learning_app/data/model/daily_topic_model.dart';
import 'package:http/http.dart' as http;

class AuthorQuotesRepository {
  // Get quotes by specific author
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
      throw Exception('Failed to fetch quotes by author: ${response.statusCode}');
    }
  }

  // Get all available authors
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

  // Search authors by name (for autocomplete functionality)
  Future<List<String>> searchAuthors(String query) async {
    try {
      final allAuthors = await getAllAuthors();
      return allAuthors
          .where((author) => author.toLowerCase().contains(query.toLowerCase()))
          .take(10) // Limit results
          .toList();
    } catch (e) {
      throw Exception('Failed to search authors: $e');
    }
  }

  // Get popular authors (predefined list as fallback)
  List<String> getPopularAuthors() {
    return [
      'Albert Einstein',
      'Steve Jobs',
      'Maya Angelou',
      'Nelson Mandela',
      'Mahatma Gandhi',
      'Mark Twain',
      'Benjamin Franklin',
      'Winston Churchill',
      'Theodore Roosevelt',
      'Martin Luther King Jr.',
    ];
  }
}