import 'package:get/get.dart';
import 'package:veggiefresh/app/modules/cart/controllers/cart_controller.dart';

import '../controllers/product_controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductController>(
      () => ProductController(Get.arguments),
    );
  }
}
