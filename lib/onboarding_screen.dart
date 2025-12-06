import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingStep> _steps = [
    OnboardingStep(
      header: 'سفارش آسان غذا با چند کلیک',
      text: 'با اپلیکیشن ترخینه می‌تونی در عرض چند ثانیه و با چند کلیک به راحتی سفارش خودت رو ثبت کنی.',
      characterImage: 'assets/images/Character-1.png',
    ),
    OnboardingStep(
      header: 'ارسال سریع سفارشات',
      text: 'حداکثر زمان تحویل غذا در ترخینه ۴۵ دقیقه است که این زمان بسته به آدرست میتونه کمتر هم بشه!',
      characterImage: 'assets/images/Character-2.png',
    ),
    OnboardingStep(
      header: 'تجربه غذای سالم و گیاهی',
      text: 'تموم غذاهای ترخینه با محصولات کشاورزی کاملا سالم و ارگانیک تهیه می‌شن تا بهترین تجربه رو بهت هدیه بدن.',
      characterImage: 'assets/images/Character.png',
    ),
  ];

  void _nextPage() {
    if (_currentPage < _steps.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to login on last step
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _steps.length,
                itemBuilder: (context, index) {
                  return _buildPage(_steps[index]);
                },
              ),
            ),
            // Next Button
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0, top: 16.0),
              child: Center(
                child: GestureDetector(
                  onTap: _nextPage,
                  child: Image.asset(
                    _currentPage == 0
                        ? 'assets/images/Next-1.png'
                        : _currentPage == 1
                            ? 'assets/images/Next-2.png'
                            : 'assets/images/Next.png',
                    width: 120,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingStep step) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Character Image
          Expanded(
            flex: 3,
            child: Center(
              child: Image.asset(
                step.characterImage,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 40),
          // Header Text
          Text(
            step.header,
            style: const TextStyle(
              fontFamily: 'IRANSansX',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF417F56),
            ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 16),
          // Description Text
          Text(
            step.text,
            style: const TextStyle(
              fontFamily: 'IRANSansX',
              fontSize: 16,
              color: Colors.black87,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class OnboardingStep {
  final String header;
  final String text;
  final String characterImage;

  OnboardingStep({
    required this.header,
    required this.text,
    required this.characterImage,
  });
}

