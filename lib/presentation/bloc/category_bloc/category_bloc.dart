// quotes_by_category_bloc.dart
import 'package:daily_learning_app/data/model/daily_topic_model.dart';
import 'package:daily_learning_app/data/repositories/category_quote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_event.dart';
part 'category_state.dart';

class QuotesByCategoryBloc extends Bloc<QuotesByCategoryEvent, QuotesByCategoryState> {
  final CategoryQuoteRepository repository;

  QuotesByCategoryBloc(this.repository) : super(QuotesByCategoryInitial()) {
    on<FetchQuotesByTagEvent>(_onFetchQuotesByTag);
    on<ResetCategorySelectionEvent>(_onResetCategorySelection);
  }

  Future<void> _onFetchQuotesByTag(
    FetchQuotesByTagEvent event,
    Emitter<QuotesByCategoryState> emit,
  ) async {
    emit(QuotesByCategoryLoading());
    try {
      final quotes = await repository.getQuotesByTag(event.tag);
      if (quotes.isNotEmpty) {
        emit(QuotesByCategoryLoaded(quotes, event.tag));
      } else {
        emit(QuotesByCategoryError("No quotes found for this category"));
      }
    } catch (e) {
      emit(QuotesByCategoryError(e.toString()));
    }
  }

  void _onResetCategorySelection(
    ResetCategorySelectionEvent event,
    Emitter<QuotesByCategoryState> emit,
  ) {
    emit(QuotesByCategoryInitial());
  }
}