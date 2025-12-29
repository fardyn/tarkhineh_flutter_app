import 'product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  int get totalPrice => product.finalPrice * quantity;
  
  int get totalOriginalPrice => product.originalPrice * quantity;
  
  int? get totalDiscount {
    if (product.discountPercent != null) {
      return totalOriginalPrice - totalPrice;
    }
    return null;
  }
}

