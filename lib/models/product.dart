class Product {
  final String? id;
  final String? category;
  final String name;
  final String description;
  final String image;
  final List<dynamic> images;
  final num priceValue;
  final String price;
  final int stock;
  final List<dynamic> colors;
  final num averageRating;
  final String? createdAt;
  final String? updatedAt;

  Product({
    required this.id,
    required this.category,
    required this.name,
    required this.description,
    required this.image,
    required this.images,
    required this.priceValue,
    required this.price,
    required this.stock,
    required this.colors,
    required this.averageRating,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromMap(Map<String, dynamic> e, String Function(dynamic) normalizeImage) {
    final id = e['_id'] ?? e['id'];
    final category = e['category'];
    final name = e['productName'] ?? e['name'] ?? e['title'] ?? 'No name';

    final priceValue = e['price'] is num
        ? e['price'] as num
        : (e['price'] != null ? num.tryParse(e['price'].toString()) ?? 0 : 0);
    final price = '\$${priceValue.toString()}';

    dynamic rawImage;
    if (e['images'] is List && e['images'].isNotEmpty) {
      rawImage = e['images'][0];
    } else if (e['image'] != null) {
      rawImage = e['image'];
    } else if (e['imageUrl'] != null) {
      rawImage = e['imageUrl'];
    }

    final image = normalizeImage(rawImage);

    return Product(
      id: id?.toString(),
      category: category?.toString(),
      name: name.toString(),
      description: e['description']?.toString() ?? '',
      image: image,
      images: e['images'] ?? (rawImage != null ? [rawImage] : []),
      priceValue: priceValue,
      price: price,
      stock: (e['stock'] is int) ? e['stock'] as int : (int.tryParse(e['stock']?.toString() ?? '0') ?? 0),
      colors: e['colors'] ?? [],
      averageRating: e['averageRating'] ?? 0,
      createdAt: e['createdAt']?.toString(),
      updatedAt: e['updatedAt']?.toString(),
    );
  }
}
