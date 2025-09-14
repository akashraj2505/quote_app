part of 'category_bloc.dart';

abstract class QuotesByCategoryEvent {}

class FetchQuotesByTagEvent extends QuotesByCategoryEvent {
  final String tag;
  FetchQuotesByTagEvent(this.tag);
}

class ResetCategorySelectionEvent extends QuotesByCategoryEvent {}

class LoadCategoriesEvent extends QuotesByCategoryEvent {}