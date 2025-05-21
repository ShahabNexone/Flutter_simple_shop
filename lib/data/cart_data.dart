// lib/data/cart_data.dart
import '../models/cart_item.dart';

class CartData {
  static List<CartItem> cartItems = [];

  static void addToCart(CartItem item) {
    final existing = cartItems.where((e) => e.productId == item.productId).toList();
    if (existing.isNotEmpty) {
      existing.first.quantity += item.quantity;
    } else {
      cartItems.add(item);
    }
  }

  static void removeFromCart(int productId) {
    cartItems.removeWhere((e) => e.productId == productId);
  }

  static void clearCart() {
    cartItems.clear();
  }

  static int get totalPrice =>
      cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);

  static int get totalCount =>
      cartItems.fold(0, (sum, item) => sum + item.quantity);
}
