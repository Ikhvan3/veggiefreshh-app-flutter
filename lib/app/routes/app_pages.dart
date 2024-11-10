import 'package:get/get.dart';
import 'package:veggiefresh/app/data/models/product_model.dart';
import 'package:veggiefresh/app/modules/auth/views/sign_up_view.dart';
import 'package:veggiefresh/app/modules/home/bindings/message_binding.dart';
import 'package:veggiefresh/app/modules/home/views/chat/chat_view.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/sign_in_view.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/cart/views/cart_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/bindings/main_binding.dart';
import '../modules/home/views/chat/chat_detail_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home/views/main_views.dart';
import '../modules/product/bindings/product_binding.dart';
import '../modules/product/views/product_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.MAIN;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.AUTHIN,
      page: () => SignInView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.AUTHUP,
      page: () => SignUpView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => const CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT,
      page: () => ProductView(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => (ChatView()),
      binding: MessageBinding(),
    ),
    GetPage(
      name: _Paths.CHATDETAIL,
      page: () => (ChatDetailView()),
      binding: MessageBinding(),
    ),
  ];
}
