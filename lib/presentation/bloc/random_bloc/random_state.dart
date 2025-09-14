
part of 'random_bloc.dart';

abstract class RandomQuoteState {}

class RandomQuoteInitial extends RandomQuoteState {}

class RandomQuoteLoading extends RandomQuoteState {}

class RandomQuoteLoaded extends RandomQuoteState {
  final DailyTopicModel quote;
  RandomQuoteLoaded(this.quote);
}

class RandomQuoteError extends RandomQuoteState {
  final String message;
  RandomQuoteError(this.message);
}