// quotes_by_author_bloc.dart
import 'package:daily_learning_app/data/model/daily_topic_model.dart';
import 'package:daily_learning_app/data/repositories/author_quote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'author_event.dart';
part 'author_state.dart';

class QuotesByAuthorBloc extends Bloc<QuotesByAuthorEvent, QuotesByAuthorState> {
  final AuthorQuotesRepository repository;

  QuotesByAuthorBloc(this.repository) : super(QuotesByAuthorInitial()) {
    on<FetchQuotesByAuthorEvent>(_onFetchQuotesByAuthor);
    on<LoadAllAuthorsEvent>(_onLoadAllAuthors);
    on<SearchAuthorsEvent>(_onSearchAuthors);
    on<ResetAuthorSelectionEvent>(_onResetAuthorSelection);
  }

  Future<void> _onFetchQuotesByAuthor(
    FetchQuotesByAuthorEvent event,
    Emitter<QuotesByAuthorState> emit,
  ) async {
    emit(QuotesByAuthorLoading());
    try {
      final quotes = await repository.getQuotesByAuthor(event.author);
      if (quotes.isNotEmpty) {
        emit(QuotesByAuthorLoaded(quotes, event.author));
      } else {
        emit(QuotesByAuthorError("No quotes found for this author"));
      }
    } catch (e) {
      emit(QuotesByAuthorError(e.toString()));
    }
  }

  Future<void> _onLoadAllAuthors(
    LoadAllAuthorsEvent event,
    Emitter<QuotesByAuthorState> emit,
  ) async {
    emit(QuotesByAuthorLoading());
    try {
      final authors = await repository.getAllAuthors();
      emit(AuthorsLoaded(authors));
    } catch (e) {
      // Fallback to popular authors
      final popularAuthors = repository.getPopularAuthors();
      emit(AuthorsLoaded(popularAuthors));
    }
  }

  Future<void> _onSearchAuthors(
    SearchAuthorsEvent event,
    Emitter<QuotesByAuthorState> emit,
  ) async {
    try {
      final authors = await repository.searchAuthors(event.query);
      emit(AuthorsSearchResults(authors, event.query));
    } catch (e) {
      emit(QuotesByAuthorError(e.toString()));
    }
  }

  void _onResetAuthorSelection(
    ResetAuthorSelectionEvent event,
    Emitter<QuotesByAuthorState> emit,
  ) {
    emit(QuotesByAuthorInitial());
  }
}