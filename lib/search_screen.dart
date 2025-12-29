import 'package:flutter/material.dart';
import 'models/product.dart';
import 'product_detail_screen.dart';
import 'utils/finglish_converter.dart';
import 'services/cart_service.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _initializeProducts();
    _filteredProducts = _allProducts;
  }

  void _initializeProducts() {
    _allProducts = [
      Product(
        id: '1',
        title: 'دلمه برگ کلم',
        imagePath: 'assets/images/Special-offer-pic-1.png',
        originalPrice: 220000,
        discountPercent: 8,
        finalPrice: 209000,
        stars: 5,
        ingredients: 'کلم، برنج، لپه، سبزی معطر، پیاز، رب گوجه فرنگی، روغن زیتون',
        rating: 5,
      ),
      Product(
        id: '2',
        title: 'بادمجان شکم‌پر',
        imagePath: 'assets/images/special-offer-pic-2.png',
        originalPrice: 150000,
        discountPercent: 18,
        finalPrice: 136000,
        stars: 4,
        ingredients: 'بادمجان، گوجه فرنگی، کدو سبز، پیاز، رب گوجه فرنگی، روغن زیتون، پنیر پارمزان',
        rating: 4,
      ),
      Product(
        id: '3',
        title: 'پنینی اسفناج',
        imagePath: 'assets/images/popular-foods-1.png',
        originalPrice: 150000,
        finalPrice: 150000,
        stars: 3,
        ingredients: 'نان پنینی، اسفناج، پنیر موتزارلا، سیر، روغن زیتون',
        rating: 3,
      ),
      Product(
        id: '4',
        title: 'پیتزا پپرونی',
        imagePath: 'assets/images/Popular-foods-2.png',
        originalPrice: 175000,
        discountPercent: 20,
        finalPrice: 150000,
        stars: 4,
        ingredients: 'خمیر پیتزا، پپرونی، پنیر موتزارلا، سس گوجه فرنگی',
        rating: 4,
      ),
      Product(
        id: '5',
        title: 'سوشی',
        imagePath: 'assets/images/sushi.png',
        originalPrice: 175000,
        discountPercent: 20,
        finalPrice: 150000,
        stars: 4,
        ingredients: 'ماهی سالمون، برنج سوشی، جلبک دریایی، خیار، آووکادو',
        rating: 4,
      ),
      Product(
        id: '6',
        title: 'راتاتویی',
        imagePath: 'assets/images/ratatouii.png',
        originalPrice: 175000,
        discountPercent: 20,
        finalPrice: 150000,
        stars: 4,
        ingredients: 'بادمجان، گوجه فرنگی، کدو سبز، پیاز، رب گوجه فرنگی، روغن زیتون، پنیر پارمزان',
        rating: 4,
      ),
    ];
  }

  void _filterProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredProducts = _allProducts;
      } else {
        final normalizedQuery = query.trim();
        
        // Convert Finglish to Farsi if needed
        String searchQuery = normalizedQuery;
        if (FinglishConverter.isFinglish(normalizedQuery)) {
          searchQuery = FinglishConverter.finglishToFarsi(normalizedQuery);
        }
        
        // Search in both original query and converted query
        _filteredProducts = _allProducts
            .where((product) {
              final titleLower = product.title.toLowerCase();
              final ingredientsLower = product.ingredients.toLowerCase();
              final queryLower = normalizedQuery.toLowerCase();
              final farsiQuery = searchQuery.toLowerCase();
              
              return titleLower.contains(normalizedQuery) ||
                     titleLower.contains(searchQuery) ||
                     ingredientsLower.contains(normalizedQuery) ||
                     ingredientsLower.contains(searchQuery) ||
                     // Also check Finglish patterns
                     _matchesFinglish(product.title, queryLower) ||
                     _matchesFinglish(product.ingredients, queryLower);
            })
            .toList();
      }
    });
  }

  bool _matchesFinglish(String text, String finglishQuery) {
    // Simple pattern matching for common Finglish words
    final patterns = {
      'pizza': 'پیتزا',
      'sushi': 'سوشی',
      'panini': 'پنینی',
      'esfenaj': 'اسفناج',
      'peperoni': 'پپرونی',
      'dolme': 'دلمه',
      'badamjan': 'بادمجان',
      'ratatouie': 'راتاتویی',
      'ratatouii': 'راتاتویی',
      'ratatouy': 'راتاتویی',
    };
    
    for (var entry in patterns.entries) {
      if (finglishQuery.contains(entry.key) && text.contains(entry.value)) {
        return true;
      }
    }
    
    return false;
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5F2E9),
      body: SafeArea(
        child: Column(
          children: [
            // Header with Search Bar
            Container(
              color: const Color(0xFF417F56),
              padding: const EdgeInsets.all(16),
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _searchController,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'جستجو...',
                          hintTextDirection: TextDirection.rtl,
                          prefixIcon: const Icon(Icons.search),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        style: const TextStyle(
                          fontFamily: 'IRANSansX',
                          fontSize: 16,
                        ),
                        onChanged: _filterProducts,
                        enableSuggestions: true,
                        autocorrect: true,
                        inputFormatters: [],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Results
            Expanded(
              child: _filteredProducts.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'نتیجه‌ای یافت نشد',
                            style: TextStyle(
                              fontFamily: 'IRANSansX',
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                            textDirection: TextDirection.rtl,
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = _filteredProducts[index];
                        return _buildProductCard(product);
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
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
          _buildNavItem('جستجو', 'assets/images/search-normal.png', true),
          _buildNavItem('سبد خرید', 'assets/images/shopping-cart.png', false),
          _buildNavItem('سفارشات', 'assets/images/receipt-2.png', false),
          _buildNavItem('پروفایل', 'assets/images/user.png', false),
        ],
      ),
    );
  }

  Widget _buildNavItem(String label, String iconPath, bool isActive) {
    final cartService = CartService();
    final cartCount = cartService.itemCount;
    final showBadge = label == 'سبد خرید' && cartCount > 0;

    return GestureDetector(
      onTap: () {
        if (label == 'خانه') {
          Navigator.pushReplacementNamed(context, '/home');
        } else if (label == 'سبد خرید') {
          Navigator.pushNamed(context, '/cart');
        } else if (label == 'سفارشات') {
          Navigator.pushNamed(context, '/orders');
        } else if (label == 'جستجو') {
          // Already on search
        }
        // TODO: Navigate to profile page
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

  Widget _buildProductCard(Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
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
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: Image.asset(
                product.imagePath,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            // Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.rtl,
                  children: [
                    Text(
                      product.title,
                      style: const TextStyle(
                        fontFamily: 'IRANSansX',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    // Stars
                    Row(
                      textDirection: TextDirection.rtl,
                      children: List.generate(5, (index) {
                        return Icon(
                          index < product.stars
                              ? Icons.star
                              : Icons.star_border,
                          color: index < product.stars
                              ? Colors.amber
                              : Colors.grey,
                          size: 16,
                        );
                      }),
                    ),
                    const SizedBox(height: 8),
                    // Price
                    Row(
                      textDirection: TextDirection.rtl,
                      children: [
                        if (product.discountPercent != null) ...[
                          Text(
                            '${_formatPrice(product.originalPrice)}',
                            style: TextStyle(
                              fontFamily: 'IRANSansX',
                              fontSize: 12,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '${product.discountPercent}٪',
                              style: const TextStyle(
                                fontFamily: 'IRANSansX',
                                fontSize: 10,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          '${_formatPrice(product.finalPrice)} تومان',
                          style: const TextStyle(
                            fontFamily: 'IRANSansX',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF417F56),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

