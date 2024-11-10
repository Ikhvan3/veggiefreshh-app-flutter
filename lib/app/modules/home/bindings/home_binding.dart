import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../controllers/main_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Main controller untuk bottom navigation
    Get.lazyPut<MainController>(
      () => MainController(),
    );

    // Controller untuk setiap tab
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
