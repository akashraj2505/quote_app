import 'package:daily_learning_app/data/model/daily_topic_model.dart';
import 'package:daily_learning_app/data/repositories/batch_quote.dart';
import 'package:daily_learning_app/data/repositories/quote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'batch_event.dart';
part 'batch_state.dart';

class BatchQuotesBloc extends Bloc<BatchQuotesEvent, BatchQuotesState> {
  final BatchQuotesRepository repository;

  BatchQuotesBloc(this.repository) : super(BatchQuotesInitial()) {
    on<FetchBatchQuotesEvent>(_onFetchBatchQuotes);
    on<RefreshBatchQuotesEvent>(_onRefreshBatchQuotes);
  }

  Future<void> _onFetchBatchQuotes(
    FetchBatchQuotesEvent event,
    Emitter<BatchQuotesState> emit,
  ) async {
    emit(BatchQuotesLoading());
    try {
      final quotes = await repository.getBatchQuotes();
      if (quotes.isNotEmpty) {
        emit(BatchQuotesLoaded(quotes));
      } else {
        emit(BatchQuotesError("No batch quotes found"));
      }
    } catch (e) {
      emit(BatchQuotesError(e.toString()));
    }
  }

  Future<void> _onRefreshBatchQuotes(
    RefreshBatchQuotesEvent event,
    Emitter<BatchQuotesState> emit,
  ) async {
    // Don't show loading for refresh, just update the data
    try {
      final quotes = await repository.getBatchQuotes();
      if (quotes.isNotEmpty) {
        emit(BatchQuotesLoaded(quotes));
      } else {
        emit(BatchQuotesError("No batch quotes found"));
      }
    } catch (e) {
      emit(BatchQuotesError(e.toString()));
    }
  }
}
