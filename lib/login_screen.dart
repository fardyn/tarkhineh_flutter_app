import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'otp_verification_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isTermsAccepted = false;

  void _sendCode() {
    if (_isTermsAccepted && _phoneController.text.length == 11) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpVerificationScreen(
            phoneNumber: _phoneController.text,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 40),
              // Logo
              Image.asset(
                'assets/images/logo-green.png',
                width: 150,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 40),
              // Title
              const Text(
                'ثبت نام/ورود',
                style: TextStyle(
                  fontFamily: 'IRANSansX',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 16),
              // Subtitle
              const Text(
                'شماره همراه خود را وارد کنید.',
                style: TextStyle(
                  fontFamily: 'IRANSansX',
                  fontSize: 16,
                  color: Colors.black87,
                ),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 40),
              // Phone Number Input
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  hintText: '09123456789',
                  hintTextDirection: TextDirection.ltr,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFF417F56), width: 2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
                style: const TextStyle(
                  fontFamily: 'IRANSansX',
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 24),
              // Terms Checkbox
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Checkbox(
                    value: _isTermsAccepted,
                    onChanged: (value) {
                      setState(() {
                        _isTermsAccepted = value ?? false;
                      });
                    },
                    activeColor: const Color(0xFF417F56),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isTermsAccepted = !_isTermsAccepted;
                        });
                      },
                      child: const Text(
                        'من قوانین و مقررات ارائه خدمات توسط ترخینه را می‌پذیرم.',
                        style: TextStyle(
                          fontFamily: 'IRANSansX',
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // Send Code Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isTermsAccepted && _phoneController.text.length == 11
                      ? _sendCode
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF417F56),
                    disabledBackgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'ارسال کد',
                    style: TextStyle(
                      fontFamily: 'IRANSansX',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

