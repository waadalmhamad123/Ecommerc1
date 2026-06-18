import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/api_service.dart';
import '../models/product.dart';

class HomeContentController extends GetxController {
  final RxList<Product> products = <Product>[].obs;

  final RxString searchQuery = ''.obs;

  final RxList<Map<String, dynamic>> categories = <Map<String, dynamic>>[].obs;

  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  final ApiService api = ApiService();
  @override
  void onInit() {
    super.onInit();
    fetchCategories();
    fetchProducts();
  }

  Future<void> fetchCategories() async {
    // Fetch categories from backend endpoint /api/product/categories (no auth required)
    isLoading.value = true;
    error.value = '';
    try {
      final items = await api.fetchCategories();

      if (items.isEmpty) {
        // fallback to default static categories if none returned
        categories.value = [
          {'name': 'laptop', 'icon': Icons.laptop_mac_outlined},
          {'name': 'camera', 'icon': Icons.camera_alt_outlined},
          {'name': 'mobile', 'icon': Icons.smartphone_outlined},
          {'name': 'shoes', 'icon': Icons.directions_walk_outlined},
          {'name': 'dress', 'icon': Icons.checkroom_outlined},
          {'name': 'watch', 'icon': Icons.watch_outlined},
        ];
      } else {
        // Map backend categories to simple {name, icon}
        categories.value = items.map<Map<String, dynamic>>((e) {
          final name = (e is Map && e['categoryName'] != null)
              ? e['categoryName'].toString()
              : (e is Map && e['name'] != null
                    ? e['name'].toString()
                    : e.toString());
          return {'name': name, 'icon': Icons.category};
        }).toList();
      }
    } catch (err) {
      // keep existing static categories on error
      categories.value = [
        {'name': 'laptop', 'icon': Icons.laptop_mac_outlined},
        {'name': 'camera', 'icon': Icons.camera_alt_outlined},
        {'name': 'mobile', 'icon': Icons.smartphone_outlined},
        {'name': 'shoes', 'icon': Icons.directions_walk_outlined},
        {'name': 'dress', 'icon': Icons.checkroom_outlined},
        {'name': 'watch', 'icon': Icons.watch_outlined},
      ];
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchProducts() async {
    isLoading.value = true;
    error.value = '';
    try {
      final items = await api.fetchProducts(page: 1, limit: 1000);

      if (items.isEmpty) {
        error.value = 'Failed to load products from any host';
        products.clear();
      } else {
        products.value = items;
      }
    } catch (err) {
      error.value = 'Error fetching products: $err';
      products.clear();
    } finally {
      isLoading.value = false;
    }
  }

  /// Fetch products from the backend using the filter endpoint.
  /// Provide at least one filter param (category or name) to narrow results.
  Future<void> fetchFilteredProducts({
    String? category,
    String? name,
    int page = 1,
    int limit = 20,
    int? minPrice,
    int? maxPrice,
  }) async {
    isLoading.value = true;
    error.value = '';
    try {
      final items = await api.filterProducts(
        category: category,
        name: name,
        page: page,
        limit: limit,
        minPrice: minPrice,
        maxPrice: maxPrice,
      );

      if (items.isEmpty) {
        // preserve existing products but expose an empty list to indicate no results
        products.clear();
        error.value = 'No products matched the filters';
      } else {
        products.value = items;
      }
    } catch (err) {
      error.value = 'Error fetching filtered products: $err';
      products.clear();
    } finally {
      isLoading.value = false;
    }
  }

  // Update the current search query used by UI. Use this from text fields.
  void updateSearch(String q) {
    searchQuery.value = q.trim();
  }

  // Returns the products filtered by the current `searchQuery`.
  // Filters by name, description and category (case-insensitive).
  List<Product> get filteredProducts {
    final q = searchQuery.value.toLowerCase();
    if (q.isEmpty) return products.toList();

    return products.where((p) {
      final name = p.name.toLowerCase();
      final desc = p.description.toLowerCase();
      final cat = (p.category ?? '').toLowerCase();
      return name.contains(q) || desc.contains(q) || cat.contains(q);
    }).toList();
  }
}
