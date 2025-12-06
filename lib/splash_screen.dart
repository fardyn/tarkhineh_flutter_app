import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Go to next screen after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/onboarding');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF417F56), // green background

      body: Stack(
        children: [
          // Green background color
          Container(
            color: const Color(0xFF417F56),
          ),

          // Background image on top
          Positioned.fill(
            child: Image.asset(
              'assets/images/splash_screen/background-splash-screen.png',
              fit: BoxFit.contain,
              repeat: ImageRepeat.repeat,
            ),
          ),

          // Content on top of background image
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              /// Center Logo
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 150,
                  fit: BoxFit.contain,
                ),
              ),

              const Spacer(),

              /// Rotating Dots Animation
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: LoadingAnimationWidget.horizontalRotatingDots(
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
