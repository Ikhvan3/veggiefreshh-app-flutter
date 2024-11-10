import 'package:get/get.dart';

import '../../../data/models/product_model.dart';

class ProductController extends GetxController {
  final ProductModel product;

  ProductController(this.product);

  var currentIndex = 0.obs;
  var isWishlist = false.obs;

  void setCurrentIndex(int index) {
    currentIndex.value = index;
  }

  void toggleWishlist() {
    isWishlist.value = !isWishlist.value;
  }

  void addToCart() {
    // Add cart logic here
    Get.snackbar("Success", "Item added to cart");
  }
}
