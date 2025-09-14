import 'package:daily_learning_app/presentation/screens/bottom_navigation/bottom_navigation.dart';
import 'package:daily_learning_app/presentation/screens/home/favourites_page.dart';
import 'package:daily_learning_app/presentation/screens/home/home_page.dart';
import 'package:daily_learning_app/presentation/screens/home/profile_page.dart';
import 'package:daily_learning_app/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/bottomnav':
        return MaterialPageRoute(builder: (_) => const BottomNavigationPage());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/favoruites':
        return MaterialPageRoute(builder: (_) => const FavouritesPage());
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("No route defined")),
          ),
        );
    }
  }
}
