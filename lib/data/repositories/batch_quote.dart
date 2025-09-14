// batch_quotes_repository.dart
import 'dart:convert';
import 'package:daily_learning_app/core/constants/app_constants.dart';
import 'package:daily_learning_app/data/model/daily_topic_model.dart';
import 'package:http/http.dart' as http;

class BatchQuotesRepository {
  // Get a batch of random quotes (useful for previous topics section)
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

  // Get quotes for previous topics (could be enhanced with local storage)
  Future<List<DailyTopicModel>> getPreviousTopics({int limit = 10}) async {
    try {
      final batchQuotes = await getBatchQuotes();
      // Return limited number of quotes for previous topics
      return batchQuotes.take(limit).toList();
    } catch (e) {
      throw Exception('Failed to fetch previous topics: $e');
    }
  }

  // Get quotes for a specific time period (future enhancement)
  Future<List<DailyTopicModel>> getQuotesForDateRange({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    // For now, return batch quotes
    // This can be enhanced when the API supports date filtering
    return getBatchQuotes();
  }

  // Cache management for offline viewing (future enhancement)
  Future<void> cacheQuotes(List<DailyTopicModel> quotes) async {
    // TODO: Implement local storage caching
    // Could use SharedPreferences, Hive, or SQLite
  }

  Future<List<DailyTopicModel>?> getCachedQuotes() async {
    // TODO: Implement cached quotes retrieval
    // Return null if no cached data available
    return null;
  }
}