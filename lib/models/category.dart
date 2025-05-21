class Category {
  int? id;
  String name;
  String iconPath; // آدرس آیکون هر دسته

  Category({this.id, required this.name, required this.iconPath});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'iconPath': iconPath,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
      iconPath: map['iconPath'],
    );
  }
}
