import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../models/product.dart';
import '../db/database_helper.dart';
import '../data/app_categories.dart';

class ProductFormScreen extends StatefulWidget {
  final Product? product;
  final bool isEdit;
  const ProductFormScreen({super.key, this.product, this.isEdit = false});

  @override
  State<ProductFormScreen> createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController priceController;
  String? _imagePath;
  int _selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.product?.name ?? '');
    priceController = TextEditingController(text: widget.product?.price.toString() ?? '');
    _imagePath = widget.product?.imagePath;
    if (widget.product != null) {
      _selectedCategoryIndex = appCategories.indexWhere((cat) => cat['title'] == widget.product!.categoryTitle);
      if (_selectedCategoryIndex == -1) _selectedCategoryIndex = 0;
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null && mounted) {
      setState(() => _imagePath = picked.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? 'ویرایش محصول' : 'افزودن محصول'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'نام محصول'),
                validator: (val) => val == null || val.isEmpty ? 'نام را وارد کنید' : null,
              ),
              TextFormField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'قیمت'),
                keyboardType: TextInputType.number,
                validator: (val) => val == null || val.isEmpty ? 'قیمت را وارد کنید' : null,
              ),
              DropdownButtonFormField<int>(
                value: _selectedCategoryIndex,
                items: List.generate(
                  appCategories.length,
                  (index) => DropdownMenuItem(
                    value: index,
                    child: Row(
                      children: [
                        Image.asset(appCategories[index]['icon']!, height: 22),
                        const SizedBox(width: 10),
                        Text(appCategories[index]['title']!),
                      ],
                    ),
                  ),
                ),
                decoration: const InputDecoration(labelText: 'دسته‌بندی'),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedCategoryIndex = val);
                },
              ),
              const SizedBox(height: 18),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: _imagePath == null
                      ? const Center(child: Text('انتخاب عکس محصول (از گالری)'))
                      : (Uri.parse(_imagePath!).isAbsolute
                      ? Image.network(_imagePath!)
                      : Image.file(File(_imagePath!), fit: BoxFit.cover)),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (_imagePath == null) {
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('لطفاً یک عکس محصول انتخاب کنید!')),
                      );
                      return;
                    }
                    try {
                      if (widget.isEdit && widget.product != null) {
                        await DatabaseHelper().updateProduct(
                          Product(
                            id: widget.product!.id,
                            name: nameController.text,
                            price: int.tryParse(priceController.text) ?? 0,
                            imagePath: _imagePath!,
                            categoryTitle: appCategories[_selectedCategoryIndex]['title']!,
                          ),
                        );
                      } else {
                        await DatabaseHelper().insertProduct(
                          Product(
                            name: nameController.text,
                            price: int.tryParse(priceController.text) ?? 0,
                            imagePath: _imagePath!,
                            categoryTitle: appCategories[_selectedCategoryIndex]['title']!,
                          ),
                        );
                      }
                      if (!mounted) return;
                      Navigator.pop(context, true);
                    } catch (e) {
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('خطا در ثبت محصول: $e')),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  widget.isEdit ? 'ذخیره تغییرات' : 'افزودن محصول',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Vazir',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
