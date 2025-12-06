import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'onboarding_screen.dart';
import 'login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'IRANSansX',
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontFamily: 'IRANSansX'),
          displayMedium: TextStyle(fontFamily: 'IRANSansX'),
          displaySmall: TextStyle(fontFamily: 'IRANSansX'),
          headlineLarge: TextStyle(fontFamily: 'IRANSansX'),
          headlineMedium: TextStyle(fontFamily: 'IRANSansX'),
          headlineSmall: TextStyle(fontFamily: 'IRANSansX'),
          titleLarge: TextStyle(fontFamily: 'IRANSansX'),
          titleMedium: TextStyle(fontFamily: 'IRANSansX'),
          titleSmall: TextStyle(fontFamily: 'IRANSansX'),
          bodyLarge: TextStyle(fontFamily: 'IRANSansX'),
          bodyMedium: TextStyle(fontFamily: 'IRANSansX'),
          bodySmall: TextStyle(fontFamily: 'IRANSansX'),
          labelLarge: TextStyle(fontFamily: 'IRANSansX'),
          labelMedium: TextStyle(fontFamily: 'IRANSansX'),
          labelSmall: TextStyle(fontFamily: 'IRANSansX'),
        ),
      ),
      home: const SplashScreen(),
      routes: {
        '/onboarding': (_) => const OnboardingScreen(),
        '/login': (_) => const LoginScreen(),
        '/home': (_) => const HomePage(),
      },
    );
  }
}

// --------------------------------------------------
// 🏠 HOME PAGE
// --------------------------------------------------

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: const Center(child: Text("Home Page Loaded!")),
    );
  }
}
