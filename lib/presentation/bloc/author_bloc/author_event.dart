part of 'author_bloc.dart';

abstract class QuotesByAuthorEvent {}

class FetchQuotesByAuthorEvent extends QuotesByAuthorEvent {
  final String author;
  FetchQuotesByAuthorEvent(this.author);
}

class LoadAllAuthorsEvent extends QuotesByAuthorEvent {}

class SearchAuthorsEvent extends QuotesByAuthorEvent {
  final String query;
  SearchAuthorsEvent(this.query);
}

class ResetAuthorSelectionEvent extends QuotesByAuthorEvent {}
