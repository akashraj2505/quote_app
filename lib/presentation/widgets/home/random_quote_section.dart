import 'package:daily_learning_app/presentation/bloc/random_bloc/random_bloc.dart';
import 'package:daily_learning_app/presentation/widgets/common/quote_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RandomQuoteSection extends StatelessWidget {
  final VoidCallback onGetRandomQuote;

  const RandomQuoteSection({
    super.key,
    required this.onGetRandomQuote,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade50, Colors.blue.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.lightbulb_outline,
              color: Colors.amber.shade600,
              size: 32,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Need More Inspiration?",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Get a random inspirational quote instantly",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          // BlocBuilder for Random Quotes
          BlocBuilder<RandomQuoteBloc, RandomQuoteState>(
            builder: (context, state) {
              if (state is RandomQuoteLoading) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  child: const CircularProgressIndicator(),
                );
              } else if (state is RandomQuoteLoaded) {
                return QuoteCard(
                  quote: state.quote.title ?? '',
                  author: state.quote.author ?? 'Unknown',
                );
              } else if (state is RandomQuoteError) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    state.message,
                    style: TextStyle(color: Colors.red.shade700),
                    textAlign: TextAlign.center,
                  ),
                );
              }
              return const SizedBox(height: 20);
            },
          ),

          ElevatedButton.icon(
            onPressed: onGetRandomQuote,
            icon: const Icon(Icons.refresh, color: Colors.white),
            label: const Text("Get Random Quote", style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade600,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 8,
              shadowColor: Colors.blue.shade200,
            ),
          ),
        ],
      ),
    );
  }
}