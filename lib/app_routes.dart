import 'package:flutter_biblioteca/screens/book_form.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: '/book_form',
      page: () => BookForm(),
    ),
  ];
}
