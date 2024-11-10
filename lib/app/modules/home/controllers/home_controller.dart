// lib/modules/home/controllers/home_controller.dart
import 'package:get/get.dart';
import 'package:veggiefresh/app/data/models/product_model.dart';
import 'package:veggiefresh/app/data/repositories/product_repository.dart';
import '../../../data/models/user_model.dart';

class HomeController extends GetxController {
  final currentUser =
      UserModel(id: null, name: '', email: '', username: '').obs;
  final products = <ProductModel>[].obs;
  final ProductRepository productService = Get.find<ProductRepository>();

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async {
    try {
      var fetchedProducts = await productService.getProducts();
      products.assignAll(fetchedProducts);
    } catch (e) {
      print("Error fetching products: $e");
    }
  }
}
