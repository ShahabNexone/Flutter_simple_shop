import 'package:flutter/material.dart';
import 'dart:io';
import '../data/app_categories.dart';
import '../models/product.dart';
import '../db/database_helper.dart';
import '../widgets/custom_button.dart';
import 'product_form_screen.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  late List<Map<String, String>> categories;
  late Map<String, List<Product>> productsByCategory;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    categories = List<Map<String, String>>.from(appCategories);
    productsByCategory = {};
    _loadProducts();
  }

  Future<List<Product>> getProductsByCategory(String categoryTitle) async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> maps = await db.query(
      'products',
      where: 'categoryTitle = ?',
      whereArgs: [categoryTitle],
    );
    return List.generate(maps.length, (i) => Product.fromMap(maps[i]));
  }

  Future<void> _loadProducts() async {
    productsByCategory.clear();
    for (var cat in categories) {
      final list = await getProductsByCategory(cat['title']!);
      productsByCategory[cat['title']!] = list;
    }
    setState(() => isLoading = false);
  }

  void _showAddCategoryDialog() {
    final nameController = TextEditingController();
    String iconPath = '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          title: const Text('افزودن دسته‌بندی'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'نام دسته‌بندی'),
              ),
              TextField(
                decoration: const InputDecoration(hintText: 'آدرس آیکون (مثلا assets/images/phone.png)'),
                onChanged: (v) => iconPath = v,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('لغو'),
            ),
            CustomButton(
              text: 'افزودن',
              onPressed: () {
                if (nameController.text.isNotEmpty && iconPath.isNotEmpty) {
                  setState(() {
                    categories.add({'title': nameController.text, 'icon': iconPath});
                    productsByCategory[nameController.text] = [];
                  });
                  Navigator.pop(context);
                }
              },
              color: Colors.deepPurple,
              borderRadius: 10,
              elevation: 2,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('پنل ادمین'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddCategoryDialog,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
        padding: const EdgeInsets.all(18),
        children: [
          ...categories.map((cat) {
            final products = productsByCategory[cat['title']] ?? [];
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: ExpansionTile(
                leading: Image.asset(cat['icon']!, width: 38, height: 38),
                title: Text(cat['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Vazir')),
                children: [
                  ...products.map((prod) => ListTile(
                    title: Text(prod.name),
                    subtitle: Text('قیمت: ${prod.price}'),
                    leading: prod.imagePath.isNotEmpty
                        ? (prod.imagePath.startsWith('/')
                        ? Image.file(File(prod.imagePath), width: 44, height: 44, fit: BoxFit.cover)
                        : Image.asset(prod.imagePath, width: 44, height: 44, fit: BoxFit.cover))
                        : null,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.amber),
                          onPressed: () async {
                            final updated = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ProductFormScreen(product: prod, isEdit: true),
                              ),
                            );
                            if (updated == true) _loadProducts();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () async {
                            await DatabaseHelper().deleteProduct(prod.id!);
                            _loadProducts();
                          },
                        ),
                      ],
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: CustomButton(
                      text: 'افزودن محصول جدید',
                      icon: Icons.add,
                      onPressed: () async {
                        final added = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProductFormScreen(
                              isEdit: false,
                              product: Product(
                                name: '',
                                price: 0,
                                imagePath: '',
                                categoryTitle: cat['title']!,
                              ),
                            ),
                          ),
                        );
                        if (added == true) _loadProducts();
                      },
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        productsByCategory.remove(cat['title']);
                        categories.remove(cat);
                      });
                    },
                    child: const Text('حذف این دسته', style: TextStyle(color: Colors.red)),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
