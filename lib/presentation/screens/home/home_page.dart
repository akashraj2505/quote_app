import 'package:daily_learning_app/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:daily_learning_app/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:daily_learning_app/presentation/bloc/random_bloc/random_bloc.dart';
import 'package:daily_learning_app/presentation/widgets/common/error_state.dart';
import 'package:daily_learning_app/presentation/widgets/home/category_section.dart';
import 'package:daily_learning_app/presentation/widgets/home/custom_sliver_appbar.dart';
import 'package:daily_learning_app/presentation/widgets/home/daily_quote_section.dart';
import 'package:daily_learning_app/presentation/widgets/home/previous_topic_section.dart';
import 'package:daily_learning_app/presentation/widgets/home/random_quote_section.dart';
import 'package:daily_learning_app/presentation/widgets/home/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _fetchInitialData();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
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

  void _fetchInitialData() {
    context.read<HomeBloc>().add(FetchDailyTopicEvent());
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    context.read<HomeBloc>().add(FetchDailyTopicEvent());
    _animationController.reset();
    _animationController.forward();
  }

  void _fetchRandomQuote() {
    context.read<RandomQuoteBloc>().add(FetchRandomQuoteEvent());
  }

  void _onSearchChanged(String query) {
    if (query.isNotEmpty) {
      // TODO: Implement search functionality
      // You can add a search bloc or filter existing quotes
      debugPrint('Searching for: $query');
    }
  }

  void _onCategorySelected(String tag) {
    context.read<QuotesByCategoryBloc>().add(FetchQuotesByTagEvent(tag));
  }

  void _onPreviousTopicTap(int index) {
    // TODO: Navigate to specific topic detail
    debugPrint('Tapped on topic $index');
  }

  void _onFavorite() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Added to favorites!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: _refresh,
            color: Colors.blue,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                // Custom App Bar
                const CustomSliverAppBar(
                  title: "QuoteVerse", // You can change this to your preferred app name
                ),

                // Content
                SliverToBoxAdapter(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Column(
                        children: [
                          // Search Bar
                          SearchBarWidget(
                            controller: _searchController,
                            onChanged: _onSearchChanged,
                          ),
                          
                          // Main Content based on state
                          _buildMainContent(state),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      // Floating Action Button for quick actions
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _fetchRandomQuote,
        backgroundColor: Colors.blue.shade600,
        icon: const Icon(Icons.auto_awesome, color: Colors.white),
        label: const Text('Inspire Me', style: TextStyle(color: Colors.white)),
        heroTag: "inspire_me_fab", // Unique tag to avoid conflicts
      ),
    );
  }

  Widget _buildMainContent(HomeState state) {
    if (state is HomeLoading) {
      return _buildLoadingState();
    } else if (state is HomeLoaded) {
      return _buildLoadedContent(state);
    } else if (state is HomeError) {
      return ErrorStateWidget(
        message: state.message,
        onRetry: _refresh,
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildLoadingState() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          const SizedBox(height: 16),
          Text(
            'Loading today\'s inspiration...',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadedContent(HomeLoaded state) {
    return Column(
      children: [
        // Daily Quote Section
        DailyQuoteSection(
          quote: state.topic.title!,
          author: state.topic.author!,
          onFavorite: _onFavorite,
        ),
        
        const SizedBox(height: 24),
        
        // Random Quote Generator Section
        RandomQuoteSection(
          onGetRandomQuote: _fetchRandomQuote,
        ),
        
        const SizedBox(height: 24),
        
        // Categories Section
        CategoriesSection(
          categories: _categories,
          onCategorySelected: _onCategorySelected,
        ),
        
        const SizedBox(height: 24),
        
        // Previous Topics Section
        PreviousTopicsSection(
          itemCount: 5,
          onTopicTap: _onPreviousTopicTap,
        ),
        
        const SizedBox(height: 100), // Bottom padding for FAB
      ],
    );
  }

  // Categories for quote exploration
  static const List<Map<String, String>> _categories = [
    {'name': 'Inspiration', 'tag': 'inspiration'},
    {'name': 'Motivation', 'tag': 'motivation'},
    {'name': 'Wisdom', 'tag': 'wisdom'},
    {'name': 'Success', 'tag': 'success'},
    {'name': 'Life', 'tag': 'life'},
    {'name': 'Love', 'tag': 'love'},
    {'name': 'Happiness', 'tag': 'happiness'},
    {'name': 'Growth', 'tag': 'growth'},
  ];
}