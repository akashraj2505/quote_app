part of 'author_bloc.dart';

abstract class QuotesByAuthorState {}

class QuotesByAuthorInitial extends QuotesByAuthorState {}

class QuotesByAuthorLoading extends QuotesByAuthorState {}

class QuotesByAuthorLoaded extends QuotesByAuthorState {
  final List<DailyTopicModel> quotes;
  final String selectedAuthor;
  
  QuotesByAuthorLoaded(this.quotes, this.selectedAuthor);
}

class AuthorsLoaded extends QuotesByAuthorState {
  final List<String> authors;
  AuthorsLoaded(this.authors);
}

class AuthorsSearchResults extends QuotesByAuthorState {
  final List<String> authors;
  final String query;
  AuthorsSearchResults(this.authors, this.query);
}

class QuotesByAuthorError extends QuotesByAuthorState {
  final String message;
  QuotesByAuthorError(this.message);
}