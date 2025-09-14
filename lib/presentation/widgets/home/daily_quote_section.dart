import 'package:daily_learning_app/presentation/widgets/common/learning_card.dart';
import 'package:flutter/material.dart';

class DailyQuoteSection extends StatelessWidget {
  final String quote;
  final String author;
  final String? imageUrl;
  final VoidCallback? onFavorite;

  const DailyQuoteSection({
    super.key,
    required this.quote,
    required this.author,
    this.imageUrl,
    this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.wb_sunny, color: Colors.orange.shade400, size: 24),
              const SizedBox(width: 8),
              Text(
                "Today's Inspiration",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          DailyLearningCard(
            quote: quote,
            author: author,
            imageUrl: imageUrl,
            onFavorite: onFavorite ?? () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Added to favorites!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}