import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../widget/product_card.dart';

class LaptopScreen extends StatefulWidget {
  const LaptopScreen({super.key});

  @override
  State<LaptopScreen> createState() => _LaptopScreenState();
}

class _LaptopScreenState extends State<LaptopScreen> {
  String selectedCategory = "laptop";

  final List<Product> products = [
    Product(
      id: null,
      category: 'laptop',
      name: 'MacBook Pro M2',
      description: '16GB RAM • 512GB SSD • 14-inch',
      image: 'assets/images/laptop.jpg',
      images: [],
      priceValue: 1200,
      price: '\$1200',
      stock: 10,
      colors: [],
      averageRating: 0,
      createdAt: null,
      updatedAt: null,
    ),
    Product(
      id: null,
      category: 'laptop',
      name: 'ASUS ROG Strix',
      description: '16GB RAM • 1TB SSD • RTX 4060',
      image: 'assets/images/laptop.jpg',
      images: [],
      priceValue: 1400,
      price: '\$1400',
      stock: 8,
      colors: [],
      averageRating: 0,
      createdAt: null,
      updatedAt: null,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        title: const Text(
          'Laptops',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Simple header and product list for the laptop category
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 200,
                    child: ProductCard(product: products[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
