class Product {
  final String id;
  final String title;
  final String imagePath;
  final int originalPrice;
  final int? discountPercent;
  final int finalPrice;
  final int stars;
  final String ingredients;
  final int rating;

  Product({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.originalPrice,
    this.discountPercent,
    required this.finalPrice,
    required this.stars,
    required this.ingredients,
    required this.rating,
  });
}

