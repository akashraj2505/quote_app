// random_quote_bloc.dart
import 'package:daily_learning_app/data/model/daily_topic_model.dart';
import 'package:daily_learning_app/data/repositories/random_quote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'random_event.dart';
part 'random_state.dart';

class RandomQuoteBloc extends Bloc<RandomQuoteEvent, RandomQuoteState> {
  final RandomQuoteRepository repository;

  RandomQuoteBloc(this.repository) : super(RandomQuoteInitial()) {
    on<FetchRandomQuoteEvent>(_onFetchRandomQuote);
  }

  Future<void> _onFetchRandomQuote(
    FetchRandomQuoteEvent event,
    Emitter<RandomQuoteState> emit,
  ) async {
    emit(RandomQuoteLoading());
    try {
      final quote = await repository.getRandomQuote();
      emit(RandomQuoteLoaded(quote));
    } catch (e) {
      emit(RandomQuoteError(e.toString()));
    }
  }
}