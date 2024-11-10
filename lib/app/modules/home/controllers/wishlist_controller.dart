import 'package:get/get.dart';

import '../../../data/models/product_model.dart';

class WishlistController extends GetxController {
  var wishlist = <ProductModel>[].obs;

  void toggleWishlist(ProductModel product) {
    if (isInWishlist(product)) {
      wishlist.removeWhere((item) => item.id == product.id);
    } else {
      wishlist.add(product);
    }
  }

  bool isInWishlist(ProductModel product) {
    return wishlist.any((item) => item.id == product.id);
  }
}
