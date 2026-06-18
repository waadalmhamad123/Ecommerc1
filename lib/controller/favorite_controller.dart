import 'package:get/get.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class FavoriteController extends GetxController {
  final favoriteProducts = <Product>[].obs;

  bool isFavorite(Product product) {
    if (product.id != null && product.id!.isNotEmpty) {
      return favoriteProducts.any((p) => p.id == product.id);
    }
    return favoriteProducts.any(
      (p) => p.name == product.name && p.image == product.image,
    );
  }

  Future<void> add(Product product) async {
    if (isFavorite(product)) return;

    try {
      final api = ApiService.shared;
      if (api != null && (product.id != null && product.id!.isNotEmpty)) {
        final ok = await api.addToFavourite(product.id!);
        if (!ok) {
          favoriteProducts.add(product);
          return;
        }
      }
    } catch (_) {}

    if (!isFavorite(product)) favoriteProducts.add(product);
  }

  Future<void> remove(Product product) async {
    if (product.id != null && product.id!.isNotEmpty) {
      favoriteProducts.removeWhere((p) => p.id == product.id);
    } else {
      favoriteProducts.removeWhere(
        (p) => p.name == product.name && p.image == product.image,
      );
    }
  }

  Future<void> toggle(Product product) async {
    if (isFavorite(product)) {
      await remove(product);
    } else {
      await add(product);
    }
  }
}
