// home_bloc.dart
import 'package:daily_learning_app/data/model/daily_topic_model.dart';
import 'package:daily_learning_app/data/repositories/daily_quote.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DailyQuoteRepository repository;

  HomeBloc(this.repository) : super(HomeInitial()) {
    on<FetchDailyTopicEvent>(_onFetchDailyTopic);
  }

  Future<void> _onFetchDailyTopic(
    FetchDailyTopicEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      final topic = await repository.getTodaysQuote();
      emit(HomeLoaded(topic));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}