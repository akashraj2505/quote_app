// category_quotes_page.dart
import 'package:daily_learning_app/data/model/daily_topic_model.dart';
import 'package:daily_learning_app/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:daily_learning_app/presentation/widgets/common/error_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryQuotesPage extends StatefulWidget {
  final String categoryName;
  final String categoryTag;

  const CategoryQuotesPage({
    super.key,
    required this.categoryName,
    required this.categoryTag,
  });

  @override
  State<CategoryQuotesPage> createState() => _CategoryQuotesPageState();
}

class _CategoryQuotesPageState extends State<CategoryQuotesPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _fetchQuotes();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
  }

  void _fetchQuotes() {
    context.read<QuotesByCategoryBloc>().add(
          FetchQuotesByTagEvent(widget.categoryTag),
        );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    _fetchQuotes();
    _animationController.reset();
    _animationController.forward();
  }

  void _onFavorite(DailyTopicModel quote) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added "${quote.author}" quote to favorites!'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _shareQuote(DailyTopicModel quote) {
    // TODO: Implement share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Share functionality coming soon!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          '${widget.categoryName} Quotes',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<QuotesByCategoryBloc, QuotesByCategoryState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: _refresh,
            color: Colors.blue,
            child: _buildContent(state),
          );
        },
      ),
    );
  }

  Widget _buildContent(QuotesByCategoryState state) {
    if (state is QuotesByCategoryLoading) {
      return _buildLoadingState();
    } else if (state is QuotesByCategoryLoaded) {
      return _buildLoadedContent(state.quotes);
    } else if (state is QuotesByCategoryError) {
      return ErrorStateWidget(
        message: state.message,
        onRetry: _refresh,
      );
    }
    return _buildEmptyState();
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          const SizedBox(height: 16),
          Text(
            'Loading ${widget.categoryName.toLowerCase()} quotes...',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadedContent(List<DailyTopicModel> quotes) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            // Header Section
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blue.shade50,
                      Colors.indigo.shade50,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.blue.shade100,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        _getCategoryIcon(widget.categoryTag),
                        color: Colors.blue.shade700,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.categoryName,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${quotes.length} inspiring quotes',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Quotes List
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final quote = quotes[index];
                  return _buildQuoteCard(quote, index);
                },
                childCount: quotes.length,
              ),
            ),

            // Bottom padding
            const SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuoteCard(DailyTopicModel quote, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TweenAnimationBuilder<double>(
        duration: Duration(milliseconds: 300 + (index * 100)),
        tween: Tween(begin: 0.0, end: 1.0),
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(0, 50 * (1 - value)),
            child: Opacity(
              opacity: value,
              child: child,
            ),
          );
        },
        child: Card(
          elevation: 2,
          shadowColor: Colors.black.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Colors.grey.shade50,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Quote Text
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.blue.shade100,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    '"${quote.title ?? "No quote available"}"',
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey.shade800,
                      height: 1.5,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Author and Actions
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '— ${quote.author ?? "Unknown"}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue.shade700,
                            ),
                          ),
                          // if (quote.keywords != null && quote.keywords!.isNotEmpty)
                          //   Padding(
                          //     padding: const EdgeInsets.only(top: 8),
                          //     child: Wrap(
                          //       spacing: 6,
                          //       runSpacing: 4,
                          //       children: quote.keywords!.take(3).map((keyword) {
                          //         return Container(
                          //           padding: const EdgeInsets.symmetric(
                          //             horizontal: 8,
                          //             vertical: 4,
                          //           ),
                          //           decoration: BoxDecoration(
                          //             color: Colors.grey.shade200,
                          //             borderRadius: BorderRadius.circular(8),
                          //           ),
                          //           child: Text(
                          //             keyword,
                          //             style: TextStyle(
                          //               fontSize: 11,
                          //               color: Colors.grey.shade700,
                          //               fontWeight: FontWeight.w500,
                          //             ),
                          //           ),
                          //         );
                          //       }).toList(),
                          //     ),
                          //   ),
                        ],
                      ),
                    ),
                    
                    // Action Buttons
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => _onFavorite(quote),
                          icon: const Icon(Icons.favorite_border),
                          color: Colors.red.shade400,
                          tooltip: 'Add to Favorites',
                        ),
                        IconButton(
                          onPressed: () => _shareQuote(quote),
                          icon: const Icon(Icons.share_outlined),
                          color: Colors.blue.shade600,
                          tooltip: 'Share Quote',
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.format_quote,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No quotes found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try refreshing or check back later',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _refresh,
            child: const Text('Refresh'),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String tag) {
    switch (tag.toLowerCase()) {
      case 'inspiration':
        return Icons.lightbulb_outline;
      case 'motivation':
        return Icons.trending_up;
      case 'wisdom':
        return Icons.school_outlined;
      case 'success':
        return Icons.star_outline;
      case 'life':
        return Icons.favorite_outline;
      case 'love':
        return Icons.favorite;
      case 'happiness':
        return Icons.sentiment_very_satisfied;
      case 'leadership':
        return Icons.groups_outlined;
      case 'change':
        return Icons.transform;
      case 'dreams':
        return Icons.nights_stay_outlined;
      default:
        return Icons.format_quote;
    }
  }
}