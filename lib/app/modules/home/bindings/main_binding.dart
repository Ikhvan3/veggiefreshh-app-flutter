import 'package:get/get.dart';
import 'package:veggiefresh/app/modules/auth/controllers/auth_controller.dart';
import 'package:veggiefresh/app/modules/home/controllers/message_controller.dart';
import '../../../data/repositories/product_repository.dart';
import '../controllers/home_controller.dart';
import '../controllers/main_controller.dart';
import '../controllers/profile_controller.dart';
import '../controllers/wishlist_controller.dart';

class MainBinding extends Bindings {
  void dependencies() {
    // Main controller untuk bottom navigation
    Get.lazyPut<MainController>(
      () => MainController(),
    );

    // Controller untuk setiap tab
    Get.lazyPut(() => ProductRepository());
    Get.lazyPut(() => AuthController());
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<ChatController>(
      () => ChatController(),
    );
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
    Get.lazyPut<WishlistController>(
      () => WishlistController(),
    );
  }
}
