import 'package:flutter/material.dart';

class QuoteCard extends StatelessWidget {
  final String quote;
  final String author;
  final VoidCallback? onFavorite;

  const QuoteCard({
    super.key,
    required this.quote,
    required this.author,
    this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "“$quote”",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "- $author",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            if (onFavorite != null)
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: onFavorite,
                  icon: const Icon(Icons.favorite_border, color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
