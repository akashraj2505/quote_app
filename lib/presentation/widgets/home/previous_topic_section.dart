import 'package:flutter/material.dart';

class PreviousTopicsSection extends StatelessWidget {
  final int itemCount;
  final Function(int index)? onTopicTap;

  const PreviousTopicsSection({
    super.key,
    this.itemCount = 5,
    this.onTopicTap,
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
              Icon(Icons.history, color: Colors.indigo.shade400, size: 24),
              const SizedBox(width: 8),
              Text(
                "Previous Topics",
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
            height: 165,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: itemCount,
              itemBuilder: (context, index) {
                final colors = [
                  Colors.purple.shade100,
                  Colors.green.shade100,
                  Colors.orange.shade100,
                  Colors.pink.shade100,
                  Colors.teal.shade100,
                ];
                
                return GestureDetector(
                  onTap: () => onTopicTap?.call(index),
                  child: Container(
                    width: 220,
                    margin: const EdgeInsets.only(right: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [colors[index % colors.length], Colors.white],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: colors[index % colors.length].withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.article_outlined,
                                  size: 16,
                                  color: colors[index % colors.length].withOpacity(0.8),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                "Day ${index + 1}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Topic ${index + 1}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          Text(
                            "Previous learning topic with inspiring content and valuable insights...",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                              height: 1.3,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey.shade600,
                                size: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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