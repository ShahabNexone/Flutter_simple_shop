import 'package:flutter/material.dart';
import '../models/product.dart';
import 'dart:io';
import '../data/cart_data.dart';
import '../widgets/custom_button.dart';
import '../models/cart_item.dart'; 

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  Widget _buildProductImage(String path) {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: path.isNotEmpty
            ? (path.startsWith('/')
                ? Image.file(
                    File(path),
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    path,
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ))
            : const Icon(Icons.image_not_supported, size: 80, color: Colors.grey),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('جزئیات محصول'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProductImage(product.imagePath),
                    const SizedBox(height: 24),
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                        fontFamily: 'Vazir',
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'قیمت: ${product.price} تومان',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.green,
                        fontFamily: 'Vazir',
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'دسته‌بندی: ${product.categoryTitle}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontFamily: 'Vazir',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'افزودن به سبد خرید',
              icon: Icons.add_shopping_cart,
              onPressed: () {
                CartData.addToCart(
                  CartItem(
                    productId: product.id!,
                    name: product.name,
                    imagePath: product.imagePath,
                    price: product.price,
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('به سبد خرید اضافه شد!')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
