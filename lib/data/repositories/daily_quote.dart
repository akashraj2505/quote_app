// daily_quote_repository.dart
import 'dart:convert';
import 'dart:developer';
import 'package:daily_learning_app/core/constants/app_constants.dart';
import 'package:daily_learning_app/data/model/daily_topic_model.dart';
import 'package:http/http.dart' as http;

class DailyQuoteRepository {
  // Get today's featured quote
  Future<DailyTopicModel> getTodaysQuote() async {
    final response = await http.get(
      Uri.parse('$baseUrl/today'),
      headers: {'Content-Type': 'application/json'},
    );
    log("daily quote response: ${response.statusCode}");
    log("daily quote response body :${response.body}");

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
}