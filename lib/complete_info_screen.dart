import 'package:flutter/material.dart';
import 'payment_screen.dart';

class CompleteInfoScreen extends StatefulWidget {
  const CompleteInfoScreen({super.key});

  @override
  State<CompleteInfoScreen> createState() => _CompleteInfoScreenState();
}

class _CompleteInfoScreenState extends State<CompleteInfoScreen> {
  String _selectedDeliveryMethod = 'ارسال توسط پیک';
  final List<String> _addresses = [
    'تهران: اقدسیه، بزرگراه ارتش، مجتمع شمیران سنتر، طبقه ۱۰',
  ];
  final TextEditingController _orderNotesController = TextEditingController();
  final TextEditingController _newAddressController = TextEditingController();
  bool _showAddAddress = false;

  @override
  void dispose() {
    _orderNotesController.dispose();
    _newAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5F2E9),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              height: 60,
              color: const Color(0xFF417F56),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  const Expanded(
                    child: Text(
                      'تکمیل اطلاعات',
                      style: TextStyle(
                        fontFamily: 'IRANSansX',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(
                      'assets/images/arrow-right.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Delivery Method
                    _buildSection(
                      'روش تحویل سفارش',
                      [
                        _buildDeliveryOption('ارسال توسط پیک', 'ارسال توسط پیک'),
                        const SizedBox(height: 12),
                        _buildDeliveryOption('تحویل حضوری', 'تحویل حضوری'),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Addresses
                    _buildSection(
                      'آدرس‌ها',
                      [
                        ..._addresses.map((address) => _buildAddressCard(address)),
                        const SizedBox(height: 12),
                        if (_showAddAddress) _buildAddAddressField(),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _showAddAddress = !_showAddAddress;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFF417F56),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              textDirection: TextDirection.rtl,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.add, color: Colors.white),
                                const SizedBox(width: 8),
                                const Text(
                                  'افزودن آدرس',
                                  style: TextStyle(
                                    fontFamily: 'IRANSansX',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Order Notes
                    _buildSection(
                      'توضیحات سفارش',
                      [
                        TextField(
                          controller: _orderNotesController,
                          textDirection: TextDirection.rtl,
                          maxLines: 4,
                          decoration: InputDecoration(
                            hintText: 'توضیحات سفارش (اختیاری)',
                            hintTextDirection: TextDirection.rtl,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            contentPadding: const EdgeInsets.all(12),
                          ),
                          style: const TextStyle(
                            fontFamily: 'IRANSansX',
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
            // Submit Button
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PaymentScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF417F56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'ثبت سفارش',
                    style: TextStyle(
                      fontFamily: 'IRANSansX',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'IRANSansX',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDeliveryOption(String title, String value) {
    final isSelected = _selectedDeliveryMethod == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDeliveryMethod = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF417F56).withOpacity(0.1)
              : Colors.grey.withOpacity(0.1),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF417F56)
                : Colors.grey.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'IRANSansX',
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? const Color(0xFF417F56) : Colors.black87,
                ),
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Color(0xFF417F56),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressCard(String address) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Expanded(
            child: Text(
              address,
              style: const TextStyle(
                fontFamily: 'IRANSansX',
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              // TODO: Edit address
            },
            icon: const Icon(Icons.edit, size: 20),
            color: const Color(0xFF417F56),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _addresses.remove(address);
              });
            },
            icon: const Icon(Icons.delete, size: 20),
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildAddAddressField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF417F56)),
      ),
      child: Column(
        children: [
          TextField(
            controller: _newAddressController,
            textDirection: TextDirection.rtl,
            decoration: InputDecoration(
              hintText: 'آدرس جدید را وارد کنید',
              hintTextDirection: TextDirection.rtl,
              border: InputBorder.none,
            ),
            style: const TextStyle(
              fontFamily: 'IRANSansX',
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    _showAddAddress = false;
                    _newAddressController.clear();
                  });
                },
                child: const Text(
                  'انصراف',
                  style: TextStyle(
                    fontFamily: 'IRANSansX',
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  if (_newAddressController.text.isNotEmpty) {
                    setState(() {
                      _addresses.add(_newAddressController.text);
                      _newAddressController.clear();
                      _showAddAddress = false;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF417F56),
                ),
                child: const Text(
                  'افزودن',
                  style: TextStyle(
                    fontFamily: 'IRANSansX',
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

