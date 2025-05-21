class Product {
  int? id;
  String name;
  int price;
  String imagePath; // آدرس asset یا فایل محلی
  String categoryTitle;

  Product({this.id, required this.name, required this.price, required this.imagePath, required this.categoryTitle});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imagePath': imagePath,
      'categoryTitle': categoryTitle,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      imagePath: map['imagePath'],
      categoryTitle: map['categoryTitle'],
    );
  }
}
