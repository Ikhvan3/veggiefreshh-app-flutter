import 'package:get/get.dart';
import 'package:veggiefresh/app/data/repositories/product_repository.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => ProductRepository());
  }
}
