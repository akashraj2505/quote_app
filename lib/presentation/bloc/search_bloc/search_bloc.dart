import 'package:daily_learning_app/data/model/daily_topic_model.dart';
import 'package:daily_learning_app/data/repositories/serach_quote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchQuotesBloc extends Bloc<SearchQuotesEvent, SearchQuotesState> {
  final SearchQuotesRepository repository;

  SearchQuotesBloc(this.repository) : super(SearchQuotesInitial()) {
    on<SearchQuotesQueryEvent>(_onSearchQuotes);
    on<LoadSearchSuggestionsEvent>(_onLoadSearchSuggestions);
    on<ClearSearchEvent>(_onClearSearch);
    on<SaveSearchQueryEvent>(_onSaveSearchQuery);
    on<LoadRecentSearchesEvent>(_onLoadRecentSearches);
  }

  Future<void> _onSearchQuotes(
    SearchQuotesQueryEvent event,
    Emitter<SearchQuotesState> emit,
  ) async {
    if (event.query.trim().isEmpty) {
      emit(SearchQuotesInitial());
      return;
    }

    emit(SearchQuotesLoading());
    try {
      final quotes = await repository.searchQuotes(event.query.trim());
      if (quotes.isNotEmpty) {
        emit(SearchQuotesLoaded(quotes, event.query));
        // Save successful search
        add(SaveSearchQueryEvent(event.query.trim()));
      } else {
        emit(SearchQuotesEmpty(event.query));
      }
    } catch (e) {
      emit(SearchQuotesError(e.toString()));
    }
  }

  Future<void> _onLoadSearchSuggestions(
    LoadSearchSuggestionsEvent event,
    Emitter<SearchQuotesState> emit,
  ) async {
    try {
      final suggestions = repository.getSearchSuggestions();
      emit(SearchSuggestionsLoaded(suggestions));
    } catch (e) {
      emit(SearchQuotesError(e.toString()));
    }
  }

  void _onClearSearch(
    ClearSearchEvent event,
    Emitter<SearchQuotesState> emit,
  ) {
    emit(SearchQuotesInitial());
  }

  Future<void> _onSaveSearchQuery(
    SaveSearchQueryEvent event,
    Emitter<SearchQuotesState> emit,
  ) async {
    try {
      await repository.saveSearchQuery(event.query);
    } catch (e) {
      // Silently fail - this is not critical
    }
  }

  Future<void> _onLoadRecentSearches(
    LoadRecentSearchesEvent event,
    Emitter<SearchQuotesState> emit,
  ) async {
    try {
      final recentSearches = await repository.getRecentSearches();
      emit(RecentSearchesLoaded(recentSearches));
    } catch (e) {
      emit(SearchQuotesError(e.toString()));
    }
  }
}