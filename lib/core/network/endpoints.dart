class Endpoints {
  static const String productBase = '/api/product';
  static const String listBase = '/api/list';

  static const String categories = '$productBase/categories';
  static const String products = '$productBase/products';
  static const String filter = '$productBase/filter';

  static String addToFavourite(String productId) => '$listBase/addToFavourite/$productId';

  static const String login = '/api/auth/login';
  static const String logout = '/api/auth/logout';
}
