part of 'search_bloc.dart';

abstract class SearchQuotesEvent {}

class SearchQuotesQueryEvent extends SearchQuotesEvent {
  final String query;
  SearchQuotesQueryEvent(this.query);
}

class LoadSearchSuggestionsEvent extends SearchQuotesEvent {}

class ClearSearchEvent extends SearchQuotesEvent {}

class SaveSearchQueryEvent extends SearchQuotesEvent {
  final String query;
  SaveSearchQueryEvent(this.query);
}

class LoadRecentSearchesEvent extends SearchQuotesEvent {}