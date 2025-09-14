part of 'batch_bloc.dart';

abstract class BatchQuotesState {}

class BatchQuotesInitial extends BatchQuotesState {}

class BatchQuotesLoading extends BatchQuotesState {}

class BatchQuotesLoaded extends BatchQuotesState {
  final List<DailyTopicModel> quotes;
  BatchQuotesLoaded(this.quotes);
}

class PreviousTopicsLoaded extends BatchQuotesState {
  final List<DailyTopicModel> quotes;
  PreviousTopicsLoaded(this.quotes);
}

class BatchQuotesError extends BatchQuotesState {
  final String message;
  BatchQuotesError(this.message);
}