part of 'category_bloc.dart';

abstract class QuotesByCategoryState {}

class QuotesByCategoryInitial extends QuotesByCategoryState {}

class QuotesByCategoryLoading extends QuotesByCategoryState {}

class QuotesByCategoryLoaded extends QuotesByCategoryState {
  final List<DailyTopicModel> quotes;
  final String selectedCategory;
  
  QuotesByCategoryLoaded(this.quotes, this.selectedCategory);
}

class CategoriesLoaded extends QuotesByCategoryState {
  final List<Map<String, String>> categories;
  CategoriesLoaded(this.categories);
}

class QuotesByCategoryError extends QuotesByCategoryState {
  final String message;
  QuotesByCategoryError(this.message);
}