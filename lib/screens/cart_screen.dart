import 'package:flutter/material.dart';
import 'dart:io';
import '../data/cart_data.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartItems = CartData.cartItems;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('سبد خرید'),
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text(
                'سبد خرید خالی است.',
                style: TextStyle(fontSize: 20, fontFamily: 'Vazir'),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartItems.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, i) {
                      final item = cartItems[i];
                      return ListTile(
                        leading: item.imagePath.isNotEmpty
                            ? (item.imagePath.startsWith('/')
                                ? Image.file(
                                    File(item.imagePath),
                                    width: 48,
                                    height: 48,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    item.imagePath,
                                    width: 48,
                                    height: 48,
                                    fit: BoxFit.cover,
                                  ))
                            : null,
                        title: Text(item.name, style: const TextStyle(fontFamily: 'Vazir')),
                        subtitle: Text('${item.price} تومان × ${item.quantity}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_forever, color: Colors.redAccent),
                          onPressed: () {
                            setState(() {
                              CartData.removeFromCart(item.productId);
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'جمع کل: ${CartData.totalPrice} تومان',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'Vazir',
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          CartData.clearCart();
                          setState(() {});
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('سفارش ثبت شد!')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'پرداخت نهایی',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Vazir',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
