import 'dart:async';
import 'package:flutter/material.dart';
import 'widgets/food_card.dart';
import 'models/product.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentSliderIndex = 0;
  Timer? _sliderTimer;
  late PageController _sliderController;
  String _selectedBranch = 'شعبه اکباتان';
  bool _showBranchDialog = false;
  bool _showGpsDialog = false;
  final Set<String> _likedItems = {};

  Product _createProduct({
    required String title,
    required String imagePath,
    required int originalPrice,
    int? discountPercent,
    required int finalPrice,
    required int stars,
    required String ingredients,
  }) {
    return Product(
      id: title,
      title: title,
      imagePath: imagePath,
      originalPrice: originalPrice,
      discountPercent: discountPercent,
      finalPrice: finalPrice,
      stars: stars,
      ingredients: ingredients,
      rating: stars,
    );
  }

  final List<String> _sliderImages = [
    'assets/images/app-slider-1.png',
    'assets/images/app-slider-2.png',
  ];

  @override
  void initState() {
    super.initState();
    _sliderController = PageController(initialPage: 0);
    _startSlider();
  }

  void _startSlider() {
    _sliderTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) {
        _currentSliderIndex = (_currentSliderIndex + 1) % _sliderImages.length;
        _sliderController.animateToPage(
          _currentSliderIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _sliderTimer?.cancel();
    _sliderController.dispose();
    super.dispose();
  }

  void _showBranchSelectionDialog() {
    setState(() {
      _showBranchDialog = true;
    });
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildBranchSelectionDialog(),
    ).then((_) {
      setState(() {
        _showBranchDialog = false;
      });
    });
  }

  void _showGpsPermissionDialog() {
    setState(() {
      _showGpsDialog = true;
    });
    showDialog(
      context: context,
      builder: (context) => _buildGpsPermissionDialog(),
    ).then((_) {
      setState(() {
        _showGpsDialog = false;
      });
    });
  }

  Widget _buildBranchSelectionDialog() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'انتخاب شعبه',
              style: TextStyle(
                fontFamily: 'IRANSansX',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildBranchCard(
                  'شعبه اکباتان',
                  'شهرک اکباتان، فاز ۳، مجتمع تجاری کوروش، طبقه سوم',
                  'assets/images/ekbatan.png',
                ),
                const SizedBox(height: 16),
                _buildBranchCard(
                  'شعبه چالوس',
                  'چالوس، خیابان ۱۷ شهریور، بعد کوچه کوروش، جنب داروخانه دکتر میلانی',
                  'assets/images/chaloos.png',
                ),
                const SizedBox(height: 16),
                _buildBranchCard(
                  'شعبه اقدسیه',
                  'خیابان اقدسیه ، نرسیده به میدان خیام، پلاک ۸',
                  'assets/images/aghdasyeh.png',
                ),
                const SizedBox(height: 16),
                _buildBranchCard(
                  'شعبه ونک',
                  'میدان ونک، خیابان فردوسی، نبش کوچه نیلوفر، پلاک ۲۶',
                  'assets/images/vanak.png',
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _showGpsPermissionDialog();
                },
                icon: Image.asset(
                  'assets/images/gps.png',
                  width: 24,
                  height: 24,
                ),
                label: const Text(
                  'انتخاب نزدیک‌ترین شعبه',
                  style: TextStyle(
                    fontFamily: 'IRANSansX',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF417F56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBranchCard(String title, String address, String imagePath) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedBranch = title;
        });
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: _selectedBranch == title
                ? const Color(0xFF417F56)
                : Colors.grey.withOpacity(0.3),
            width: _selectedBranch == title ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                imagePath,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.rtl,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'IRANSansX',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address,
                    style: const TextStyle(
                      fontFamily: 'IRANSansX',
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGpsPermissionDialog() {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'اجازه دسترسی',
              style: TextStyle(
                fontFamily: 'IRANSansX',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 16),
            const Text(
              'لطفا برای انتخاب نزدیک‌ترین شعبه، GPS دستگاه را روشن کنید.',
              style: TextStyle(
                fontFamily: 'IRANSansX',
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 24),
            Row(
              textDirection: TextDirection.rtl,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF417F56)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'انصراف',
                      style: TextStyle(
                        fontFamily: 'IRANSansX',
                        color: Color(0xFF417F56),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Request GPS permission
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF417F56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'تایید',
                      style: TextStyle(
                        fontFamily: 'IRANSansX',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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
            _buildHeader(),
            // Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Slider
                    _buildSlider(),
                    // Menu Section
                    _buildMenuSection(),
                    // Special Offers
                    _buildSpecialOffersSection(),
                    // Popular Foods
                    _buildPopularFoodsSection(),
                    // Non-Iranian Foods
                    _buildNonIranianFoodsSection(),
                    const SizedBox(height: 80), // Space for bottom nav
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 60,
      color: const Color(0xFF417F56),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          // Logo
          Image.asset(
            'assets/images/logo.png',
            height: 40,
            fit: BoxFit.contain,
          ),
          const Spacer(),
          // Branch Dropdown
          GestureDetector(
            onTap: _showBranchSelectionDialog,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                textDirection: TextDirection.rtl,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/location.png',
                    width: 16,
                    height: 16,
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'شعبه',
                    style: TextStyle(
                      fontFamily: 'IRANSansX',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Image.asset(
                    'assets/images/arrow-down.png',
                    width: 16,
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlider() {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        itemCount: _sliderImages.length,
        controller: _sliderController,
        onPageChanged: (index) {
          setState(() {
            _currentSliderIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return Image.asset(
            _sliderImages[index],
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }

  Widget _buildMenuSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'منوی رستوران',
                style: TextStyle(
                  fontFamily: 'IRANSansX',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textDirection: TextDirection.rtl,
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildMenuSquare('غذای اصلی', 'assets/images/ghaza-asli.png'),
                _buildMenuSquare('پیش غذا', 'assets/images/bish-ghaza.png'),
                _buildMenuSquare('دسر', 'assets/images/ghaza-asli.png'), // Placeholder
                _buildMenuSquare('نوشیدنی', 'assets/images/ghaza-asli.png'), // Placeholder
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSquare(String title, String imagePath) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to menu page
      },
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(left: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 60,
              height: 60,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'IRANSansX',
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              textDirection: TextDirection.rtl,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecialOffersSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'پیشنهاد ویژه:',
                style: TextStyle(
                  fontFamily: 'IRANSansX',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textDirection: TextDirection.rtl,
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 320,
            child: ListView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                FoodCard(
                  imagePath: 'assets/images/Special-offer-pic-1.png',
                  title: 'دلمه برگ کلم',
                  originalPrice: 220000,
                  discountPercent: 8,
                  finalPrice: 209000,
                  stars: 5,
                  isLiked: _likedItems.contains('دلمه برگ کلم'),
                  onLike: () {
                    setState(() {
                      if (_likedItems.contains('دلمه برگ کلم')) {
                        _likedItems.remove('دلمه برگ کلم');
                      } else {
                        _likedItems.add('دلمه برگ کلم');
                      }
                    });
                  },
                  onAddToCart: () {
                    // TODO: Add to cart
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          product: _createProduct(
                            title: 'دلمه برگ کلم',
                            imagePath: 'assets/images/Special-offer-pic-1.png',
                            originalPrice: 220000,
                            discountPercent: 8,
                            finalPrice: 209000,
                            stars: 5,
                            ingredients: 'کلم، برنج، لپه، سبزی معطر، پیاز، رب گوجه فرنگی، روغن زیتون',
                          ),
                        ),
                      ),
                    );
                  },
                ),
                FoodCard(
                  imagePath: 'assets/images/special-offer-pic-2.png',
                  title: 'بادمجان شکم‌پر',
                  originalPrice: 150000,
                  discountPercent: 18,
                  finalPrice: 136000,
                  stars: 4,
                  isLiked: _likedItems.contains('بادمجان شکم‌پر'),
                  onLike: () {
                    setState(() {
                      if (_likedItems.contains('بادمجان شکم‌پر')) {
                        _likedItems.remove('بادمجان شکم‌پر');
                      } else {
                        _likedItems.add('بادمجان شکم‌پر');
                      }
                    });
                  },
                  onAddToCart: () {
                    // TODO: Add to cart
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          product: _createProduct(
                            title: 'بادمجان شکم‌پر',
                            imagePath: 'assets/images/special-offer-pic-2.png',
                            originalPrice: 150000,
                            discountPercent: 18,
                            finalPrice: 136000,
                            stars: 4,
                            ingredients: 'بادمجان، گوجه فرنگی، کدو سبز، پیاز، رب گوجه فرنگی، روغن زیتون، پنیر پارمزان',
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularFoodsSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'غذاهای محبوب',
                style: TextStyle(
                  fontFamily: 'IRANSansX',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textDirection: TextDirection.rtl,
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 320,
            child: ListView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                FoodCard(
                  imagePath: 'assets/images/popular-foods-1.png',
                  title: 'پنینی اسفناج',
                  originalPrice: 150000,
                  finalPrice: 150000,
                  stars: 3,
                  isLiked: _likedItems.contains('پنینی اسفناج'),
                  onLike: () {
                    setState(() {
                      if (_likedItems.contains('پنینی اسفناج')) {
                        _likedItems.remove('پنینی اسفناج');
                      } else {
                        _likedItems.add('پنینی اسفناج');
                      }
                    });
                  },
                  onAddToCart: () {
                    // TODO: Add to cart
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          product: _createProduct(
                            title: 'پنینی اسفناج',
                            imagePath: 'assets/images/popular-foods-1.png',
                            originalPrice: 150000,
                            finalPrice: 150000,
                            stars: 3,
                            ingredients: 'نان پنینی، اسفناج، پنیر موتزارلا، سیر، روغن زیتون',
                          ),
                        ),
                      ),
                    );
                  },
                ),
                FoodCard(
                  imagePath: 'assets/images/Popular-foods-2.png',
                  title: 'پیتزا پپرونی',
                  originalPrice: 175000,
                  discountPercent: 20,
                  finalPrice: 150000,
                  stars: 4,
                  isLiked: _likedItems.contains('پیتزا پپرونی'),
                  onLike: () {
                    setState(() {
                      if (_likedItems.contains('پیتزا پپرونی')) {
                        _likedItems.remove('پیتزا پپرونی');
                      } else {
                        _likedItems.add('پیتزا پپرونی');
                      }
                    });
                  },
                  onAddToCart: () {
                    // TODO: Add to cart
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          product: _createProduct(
                            title: 'پیتزا پپرونی',
                            imagePath: 'assets/images/Popular-foods-2.png',
                            originalPrice: 175000,
                            discountPercent: 20,
                            finalPrice: 150000,
                            stars: 4,
                            ingredients: 'خمیر پیتزا، پپرونی، پنیر موتزارلا، سس گوجه فرنگی',
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNonIranianFoodsSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'غذاهای غیر ایرانی',
                style: TextStyle(
                  fontFamily: 'IRANSansX',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textDirection: TextDirection.rtl,
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 320,
            child: ListView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                FoodCard(
                  imagePath: 'assets/images/sushi.png',
                  title: 'سوشی',
                  originalPrice: 175000,
                  discountPercent: 20,
                  finalPrice: 150000,
                  stars: 4,
                  isLiked: _likedItems.contains('سوشی'),
                  onLike: () {
                    setState(() {
                      if (_likedItems.contains('سوشی')) {
                        _likedItems.remove('سوشی');
                      } else {
                        _likedItems.add('سوشی');
                      }
                    });
                  },
                  onAddToCart: () {
                    // TODO: Add to cart
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          product: _createProduct(
                            title: 'سوشی',
                            imagePath: 'assets/images/sushi.png',
                            originalPrice: 175000,
                            discountPercent: 20,
                            finalPrice: 150000,
                            stars: 4,
                            ingredients: 'ماهی سالمون، برنج سوشی، جلبک دریایی، خیار، آووکادو',
                          ),
                        ),
                      ),
                    );
                  },
                ),
                FoodCard(
                  imagePath: 'assets/images/ratatouii.png',
                  title: 'راتاتویی',
                  originalPrice: 175000,
                  discountPercent: 20,
                  finalPrice: 150000,
                  stars: 4,
                  isLiked: _likedItems.contains('راتاتویی'),
                  onLike: () {
                    setState(() {
                      if (_likedItems.contains('راتاتویی')) {
                        _likedItems.remove('راتاتویی');
                      } else {
                        _likedItems.add('راتاتویی');
                      }
                    });
                  },
                  onAddToCart: () {
                    // TODO: Add to cart
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(
                          product: _createProduct(
                            title: 'راتاتویی',
                            imagePath: 'assets/images/ratatouii.png',
                            originalPrice: 175000,
                            discountPercent: 20,
                            finalPrice: 150000,
                            stars: 4,
                            ingredients: 'بادمجان، گوجه فرنگی، کدو سبز، پیاز، رب گوجه فرنگی، روغن زیتون، پنیر پارمزان',
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
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
          _buildNavItem('خانه', 'assets/images/home.png', true),
          _buildNavItem('جستجو', 'assets/images/search-normal.png', false),
          _buildNavItem('سبد خرید', 'assets/images/shopping-cart.png', false),
          _buildNavItem('سفارشات', 'assets/images/receipt-2.png', false),
          _buildNavItem('پروفایل', 'assets/images/user.png', false),
        ],
      ),
    );
  }

  Widget _buildNavItem(String label, String iconPath, bool isActive) {
    return GestureDetector(
      onTap: () {
        if (label == 'جستجو') {
          Navigator.pushNamed(context, '/search');
        } else if (label == 'خانه') {
          // Already on home
        }
        // TODO: Navigate to other pages (cart, orders, profile)
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

