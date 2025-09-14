import 'package:daily_learning_app/data/repositories/author_quote.dart';
import 'package:daily_learning_app/data/repositories/batch_quote.dart';
import 'package:daily_learning_app/data/repositories/category_quote.dart';
import 'package:daily_learning_app/data/repositories/daily_quote.dart';
import 'package:daily_learning_app/data/repositories/quote.dart';
import 'package:daily_learning_app/data/repositories/random_quote.dart';
import 'package:daily_learning_app/data/repositories/serach_quote.dart';
import 'package:daily_learning_app/presentation/bloc/author_bloc/author_bloc.dart';
import 'package:daily_learning_app/presentation/bloc/batch_bloc/batch_bloc.dart';
import 'package:daily_learning_app/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:daily_learning_app/data/repositories/quote.dart';
import 'package:daily_learning_app/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:daily_learning_app/presentation/bloc/random_bloc/random_bloc.dart';
import 'package:daily_learning_app/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:daily_learning_app/core/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Home BLoC for daily quotes
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(DailyQuoteRepository()),
        ),
        
        // Random Quote BLoC
        BlocProvider<RandomQuoteBloc>(
          create: (context) => RandomQuoteBloc(RandomQuoteRepository()),
        ),
        
        // Quotes by Category BLoC
        BlocProvider<QuotesByCategoryBloc>(
          create: (context) => QuotesByCategoryBloc(CategoryQuoteRepository()),
        ),
        
        // Quotes by Author BLoC
        BlocProvider<QuotesByAuthorBloc>(
          create: (context) => QuotesByAuthorBloc(AuthorQuotesRepository()),
        ),
        
        // Batch Quotes BLoC
        BlocProvider<BatchQuotesBloc>(
          create: (context) => BatchQuotesBloc(BatchQuotesRepository()),
        ),
        
        // Search Quotes BLoC
        BlocProvider<SearchQuotesBloc>(
          create: (context) => SearchQuotesBloc(SearchQuotesRepository()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Daily Learning",
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: '/', // starts with splash
      ),
    );
  }
}
