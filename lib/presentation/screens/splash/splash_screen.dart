import 'package:daily_learning_app/core/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _navigateNext() {
    Navigator.pushReplacementNamed(context, "/bottomnav");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(
          AppImages.splash,
          fit: BoxFit.contain,
          repeat: false, // play once
          onLoaded: (composition) {
            Future.delayed(composition.duration, () {
              _navigateNext();
            });
          },
        ),
      ),
    );
  }
}
