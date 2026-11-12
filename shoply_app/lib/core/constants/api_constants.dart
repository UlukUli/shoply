class ApiConstants {
  ApiConstants._();

  // 10.0.2.2 — специальный адрес Android-эмулятора для доступа к localhost:8080 компьютера
  static const String baseUrl = 'http://10.0.2.2:8080/api';

  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String productsEndpoint = '/products';
  static const String categoriesEndpoint = '/categories';
  static const String cartEndpoint = '/cart';
  static const String ordersEndpoint = '/orders';

  static const String tokenKey = 'auth_token';
  static const String userKey = 'auth_user';
}