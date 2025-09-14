import 'package:flutter/material.dart';

class CategoriesSection extends StatelessWidget {
  final List<Map<String, String>> categories;
  final Function(String tag) onCategorySelected;

  const CategoriesSection({
    super.key,
    required this.categories,
    required this.onCategorySelected,
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
              Icon(Icons.category, color: Colors.green.shade400, size: 24),
              const SizedBox(width: 8),
              Text(
                "Explore by Category",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return Container(
                  margin: const EdgeInsets.only(right: 12),
                  child: FilterChip(
                    label: Text(
                      category['name']!,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    onSelected: (selected) {
                      if (selected) {
                        onCategorySelected(category['tag']!);
                      }
                    },
                    backgroundColor: Colors.white,
                    selectedColor: Colors.blue.shade100,
                    checkmarkColor: Colors.blue.shade600,
                    side: BorderSide(color: Colors.grey.shade300),
                    elevation: 2,
                    shadowColor: Colors.grey.shade200,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}