// random_quote_repository.dart
import 'dart:convert';
import 'dart:developer';
import 'package:daily_learning_app/core/constants/app_constants.dart';
import 'package:daily_learning_app/data/model/daily_topic_model.dart';
import 'package:http/http.dart' as http;

class RandomQuoteRepository {
  // Get a random quote
  Future<DailyTopicModel> getRandomQuote() async {
    final response = await http.get(
      Uri.parse('$baseUrl/quotes/random'),
      headers: {'Content-Type': 'application/json'},
    );
    log("random quote response statuscode:${response.statusCode}");
    log("random quote reponse body:${response.body}");

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
}