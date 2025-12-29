import 'package:flutter/material.dart';
import 'models/product.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  // Sample order data
  final List<Map<String, dynamic>> _orders = [
    {
      'id': '21549019',
      'status': 'در حال آماده‌سازی',
      'date': '۱۴۰۳/۰۹/۱۵',
      'time': '۱۴:۳۰',
      'items': [
        {'name': 'پیتزا پپرونی', 'quantity': 2, 'price': 300000},
        {'name': 'سوشی', 'quantity': 1, 'price': 150000},
      ],
      'total': 450000,
    },
  ];

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
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
              child: const Row(
                textDirection: TextDirection.rtl,
                children: [
                  Expanded(
                    child: Text(
                      'سفارشات',
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
                ],
              ),
            ),
            // Content
            Expanded(
              child: _orders.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.receipt_long_outlined,
                            size: 80,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'شما هنوز سفارشی ثبت نکرده‌اید',
                            style: TextStyle(
                              fontFamily: 'IRANSansX',
                              fontSize: 18,
                              color: Colors.black87,
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _orders.length,
                      itemBuilder: (context, index) {
                        return _buildOrderCard(_orders[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        textDirection: TextDirection.rtl,
        children: [
          // Order ID and Status
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'کد سفارش: ${order['id']}',
                style: const TextStyle(
                  fontFamily: 'IRANSansX',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF417F56).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  order['status'],
                  style: const TextStyle(
                    fontFamily: 'IRANSansX',
                    fontSize: 12,
                    color: Color(0xFF417F56),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Date and Time
          Text(
            '${order['date']} - ${order['time']}',
            style: TextStyle(
              fontFamily: 'IRANSansX',
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          // Items
          ...(order['items'] as List).map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                textDirection: TextDirection.rtl,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${item['name']} × ${item['quantity']}',
                    style: const TextStyle(
                      fontFamily: 'IRANSansX',
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    '${_formatPrice(item['price'])} تومان',
                    style: const TextStyle(
                      fontFamily: 'IRANSansX',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }),
          const Divider(),
          // Total
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'جمع کل:',
                style: TextStyle(
                  fontFamily: 'IRANSansX',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${_formatPrice(order['total'])} تومان',
                style: const TextStyle(
                  fontFamily: 'IRANSansX',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF417F56),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem('خانه', 'assets/images/home.png', false),
          _buildNavItem('جستجو', 'assets/images/search-normal.png', false),
          _buildNavItem('سبد خرید', 'assets/images/shopping-cart.png', false),
          _buildNavItem('سفارشات', 'assets/images/receipt-2.png', true),
          _buildNavItem('پروفایل', 'assets/images/user.png', false),
        ],
      ),
    );
  }

  Widget _buildNavItem(String label, String iconPath, bool isActive) {
    return GestureDetector(
      onTap: () {
        if (label == 'خانه') {
          Navigator.pushReplacementNamed(context, '/home');
        } else if (label == 'جستجو') {
          Navigator.pushReplacementNamed(context, '/search');
        } else if (label == 'سبد خرید') {
          Navigator.pushNamed(context, '/cart');
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            width: 24,
            height: 24,
            color: isActive ? const Color(0xFF417F56) : Colors.grey,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'IRANSansX',
              fontSize: 12,
              color: isActive ? const Color(0xFF417F56) : Colors.grey,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

