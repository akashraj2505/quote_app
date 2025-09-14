import 'package:daily_learning_app/core/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  bool _showContent = false;

  @override
  void initState() {
    super.initState();
    
    // Initialize fade animation controller
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    // Start animations sequence - NO AUTO NAVIGATION
    _startAnimationSequence();
  }

  void _startAnimationSequence() async {
    // Wait a bit for the Lottie animation to start
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Show text and button with fade animation
    setState(() {
      _showContent = true;
    });
    _fadeController.forward();
    // NO AUTO NAVIGATION - Only manual navigation
  }

  void _navigateNext() {
    // Only navigate when button is pressed
    Navigator.pushReplacementNamed(context, "/bottomnav");
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF8F9FA),
              Color(0xFFFFFFFF),
              Color(0xFFF0F4F8),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Lottie Animation - explicitly no onComplete callback
              Expanded(
                flex: 3,
                child: Center(
                  child: Lottie.asset(
                    AppImages.splash,
                    fit: BoxFit.contain,
                    repeat: false,
                    animate: true,
                    // NO onComplete callback to prevent auto navigation
                  ),
                ),
              ),

              // Animated Content
              Expanded(
                flex: 2,
                child: AnimatedOpacity(
                  opacity: _showContent ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 800),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Main Title
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: const Text(
                            "A new quote, a new you – every single day!",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2D3748),
                              height: 1.4,
                              letterSpacing: 0.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Subtitle
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: const Text(
                          "Transform your mindset with daily inspiration",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF718096),
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Get Started Button - ONLY way to navigate
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: ElevatedButton(
                          onPressed: _navigateNext, // Only manual navigation
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4299E1),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 48,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 4,
                            shadowColor: const Color(0xFF4299E1).withOpacity(0.3),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                "Get Started",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.arrow_forward_rounded,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}