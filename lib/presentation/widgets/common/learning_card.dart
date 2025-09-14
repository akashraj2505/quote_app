import 'package:daily_learning_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class DailyLearningCard extends StatelessWidget {
  final String quote;
  final String author;
  final String? imageUrl;
  final VoidCallback? onFavorite;

  const DailyLearningCard({
    super.key,
    required this.quote,
    required this.author,
    this.imageUrl,
    this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (imageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(imageUrl!, height: 180, fit: BoxFit.cover),
            ),
          const SizedBox(height: 16),
          Text(
            '"$quote"',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.background,
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '- $author',
              style: const TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: AppColors.textDark,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: const Icon(Icons.favorite_border, color: Colors.redAccent),
              onPressed: onFavorite,
            ),
          ),
        ],
      ),
    );
  }
}
