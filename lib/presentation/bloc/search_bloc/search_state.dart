part of 'search_bloc.dart';

abstract class SearchQuotesState {}

class SearchQuotesInitial extends SearchQuotesState {}

class SearchQuotesLoading extends SearchQuotesState {}

class SearchQuotesLoaded extends SearchQuotesState {
  final List<DailyTopicModel> quotes;
  final String query;
  
  SearchQuotesLoaded(this.quotes, this.query);
}

class SearchQuotesEmpty extends SearchQuotesState {
  final String query;
  SearchQuotesEmpty(this.query);
}

class SearchSuggestionsLoaded extends SearchQuotesState {
  final List<String> suggestions;
  SearchSuggestionsLoaded(this.suggestions);
}

class RecentSearchesLoaded extends SearchQuotesState {
  final List<String> recentSearches;
  RecentSearchesLoaded(this.recentSearches);
}

class SearchQuotesError extends SearchQuotesState {
  final String message;
  SearchQuotesError(this.message);
}