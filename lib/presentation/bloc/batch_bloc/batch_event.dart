part of 'batch_bloc.dart';

abstract class BatchQuotesEvent {}

class FetchBatchQuotesEvent extends BatchQuotesEvent {}

class RefreshBatchQuotesEvent extends BatchQuotesEvent {}

class FetchPreviousTopicsEvent extends BatchQuotesEvent {
  final int limit;
  FetchPreviousTopicsEvent({this.limit = 10});
}