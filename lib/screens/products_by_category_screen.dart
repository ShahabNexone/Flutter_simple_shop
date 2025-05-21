import 'package:flutter/material.dart';
import 'dart:io';
import '../db/database_helper.dart';
import '../models/product.dart';
import 'product_detail_screen.dart';

class ProductsByCategoryScreen extends StatelessWidget {
  const ProductsByCategoryScreen({super.key, required this.categoryTitle});
  final String categoryTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(categoryTitle, style: const TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: FutureBuilder<List<Product>>(
        future: DatabaseHelper().getProducts(categoryTitle: categoryTitle),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'محصولی در این دسته ثبت نشده.\nبرای افزودن محصول جدید به پنل ادمین بروید.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
            );
          }
          final products = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final p = products[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetailScreen(product: p),
                    ),
                  );
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: p.imagePath.isNotEmpty
                        ? (p.imagePath.startsWith('/')
                            ? Image.file(
                                File(p.imagePath),
                                width: 48,
                                height: 48,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                p.imagePath,
                                width: 48,
                                height: 48,
                                fit: BoxFit.cover,
                              ))
                        : null,
                    title: Text(p.name, style: const TextStyle(fontFamily: 'Vazir')),
                    subtitle: Text('${p.price.toString()} تومان',
                        style: const TextStyle(color: Colors.green, fontFamily: 'Vazir')),
                    trailing: IconButton(
                      icon: const Icon(Icons.add_shopping_cart, color: Colors.deepPurple),
                      onPressed: () {
                        // CartData.addToCart(
                        //   CartItem(
                        //     productId: p.id!,
                        //     name: p.name,
                        //     imagePath: p.imagePath,
                        //     price: p.price,
                        //   ),
                        // );
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   const SnackBar(content: Text('به سبد خرید اضافه شد!')),
                        // );
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => ProductsByCategoryScreen(categoryTitle: categoryTitle),
            ),
          );
        },
        child: const Icon(Icons.refresh),
        tooltip: 'بارگذاری مجدد',
      ),
    );
  }
}
