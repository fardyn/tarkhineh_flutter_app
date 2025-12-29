import 'package:flutter/material.dart';
import 'models/cart_item.dart';
import 'models/product.dart';
import 'services/cart_service.dart';
import 'product_detail_screen.dart';
import 'complete_info_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartService _cartService = CartService();

  @override
  void initState() {
    super.initState();
  }

  void _updateCart() {
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Update when returning to this screen
    _updateCart();
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = _cartService.items;
    final isEmpty = items.isEmpty;

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
                      'سبد خرید',
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
              child: isEmpty
                  ? _buildEmptyCart()
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          // Cart Items List
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              return _buildCartItem(items[index]);
                            },
                          ),
                          const SizedBox(height: 16),
                          // Price Summary
                          _buildPriceSummary(),
                          const SizedBox(height: 100), // Space for bottom nav
                        ],
                      ),
                    ),
            ),
            // Complete Info Button
            if (!isEmpty)
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
                          builder: (context) => const CompleteInfoScreen(),
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
                      'تکمیل اطلاعات',
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
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 24),
            const Text(
              'شما در حال حاضر هیچ محصولی به سبد خرید اضافه نکرده‌اید!',
              style: TextStyle(
                fontFamily: 'IRANSansX',
                fontSize: 18,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF417F56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'منوی رستوران',
                  style: TextStyle(
                    fontFamily: 'IRANSansX',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(CartItem cartItem) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
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
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              cartItem.product.imagePath,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.rtl,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          product: cartItem.product,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    cartItem.product.title,
                    style: const TextStyle(
                      fontFamily: 'IRANSansX',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${_formatPrice(cartItem.product.finalPrice)} تومان',
                  style: const TextStyle(
                    fontFamily: 'IRANSansX',
                    fontSize: 14,
                    color: Color(0xFF417F56),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                // Quantity Controls
                Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (cartItem.quantity > 1) {
                          _cartService.updateQuantity(
                            cartItem.product,
                            cartItem.quantity - 1,
                          );
                          _updateCart();
                        } else {
                          _cartService.removeFromCart(cartItem.product);
                          _updateCart();
                        }
                      },
                      icon: const Icon(Icons.remove_circle_outline),
                      color: const Color(0xFF417F56),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        '${cartItem.quantity}',
                        style: const TextStyle(
                          fontFamily: 'IRANSansX',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _cartService.updateQuantity(
                          cartItem.product,
                          cartItem.quantity + 1,
                        );
                        _updateCart();
                      },
                      icon: const Icon(Icons.add_circle_outline),
                      color: const Color(0xFF417F56),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceSummary() {
    final totalPrice = _cartService.totalPrice;
    final totalDiscount = _cartService.totalDiscount;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
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
        children: [
          // تخفیف محصولات
          if (totalDiscount > 0)
            Row(
              textDirection: TextDirection.rtl,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'تخفیف محصولات',
                  style: TextStyle(
                    fontFamily: 'IRANSansX',
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  '${_formatPrice(totalDiscount)} تومان',
                  style: const TextStyle(
                    fontFamily: 'IRANSansX',
                    fontSize: 14,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          if (totalDiscount > 0) const SizedBox(height: 12),
          // Warning
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'هزینه ارسال در ادامه بر اساس آدرس، زمان و نحوه ارسال انتخابی شما محاسبه و به این مبلغ اضافه خواهد شد.',
              style: TextStyle(
                fontFamily: 'IRANSansX',
                fontSize: 12,
                color: Colors.orange,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
          const SizedBox(height: 16),
          // Total
          Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'مبلغ قابل پرداخت',
                style: TextStyle(
                  fontFamily: 'IRANSansX',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                '${_formatPrice(totalPrice)} تومان',
                style: const TextStyle(
                  fontFamily: 'IRANSansX',
                  fontSize: 18,
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
          _buildNavItem('سبد خرید', 'assets/images/shopping-cart.png', true),
          _buildNavItem('سفارشات', 'assets/images/receipt-2.png', false),
          _buildNavItem('پروفایل', 'assets/images/user.png', false),
        ],
      ),
    );
  }

  Widget _buildNavItem(String label, String iconPath, bool isActive) {
    final cartCount = _cartService.itemCount;
    final showBadge = label == 'سبد خرید' && cartCount > 0;

    return GestureDetector(
      onTap: () {
        if (label == 'خانه') {
          Navigator.pushReplacementNamed(context, '/home');
        } else if (label == 'جستجو') {
          Navigator.pushReplacementNamed(context, '/search');
        } else if (label == 'سفارشات') {
          Navigator.pushNamed(context, '/orders');
        }
      },
      child: Stack(
        children: [
          Column(
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
          if (showBadge)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Color(0xFF417F56),
                  shape: BoxShape.circle,
                ),
                constraints: const BoxConstraints(
                  minWidth: 20,
                  minHeight: 20,
                ),
                child: Center(
                  child: Text(
                    '$cartCount',
                    style: const TextStyle(
                      fontFamily: 'IRANSansX',
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

