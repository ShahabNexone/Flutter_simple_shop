class CartItem {
  final int productId;
  final String name;
  final String imagePath;
  final int price;
  int quantity;

  CartItem({
    required this.productId,
    required this.name,
    required this.imagePath,
    required this.price,
    this.quantity = 1,
  });
}
