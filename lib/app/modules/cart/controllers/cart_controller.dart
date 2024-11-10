import 'package:get/get.dart';

import '../../../data/models/cart_model.dart';
import '../../../data/models/product_model.dart';

class CartController extends GetxController {
  var carts = <CartModel>[].obs;

  void addCart(ProductModel product) {
    if (productExist(product)) {
      int index =
          carts.indexWhere((element) => element.product!.id == product.id);
      carts[index].quantity = (carts[index].quantity ?? 0) + 1;
    } else {
      carts.add(
        CartModel(
          id: carts.length,
          product: product,
          quantity: 1,
        ),
      );
    }
  }

  void removeCart(int id) {
    carts.removeAt(id);
  }

  void addQuantity(int id) {
    carts[id].quantity = (carts[id].quantity ?? 0) + 1;
  }

  void reduceQuantity(int id) {
    carts[id].quantity = (carts[id].quantity ?? 0) - 1;
    if (carts[id].quantity == 0) {
      carts.removeAt(id);
    }
  }

  int totalItems() {
    int total = 0;
    for (var item in carts) {
      total += item.quantity!;
    }
    return total;
  }

  double totalPrice() {
    double total = 0;
    for (var item in carts) {
      total += (item.quantity! * item.product!.price!);
    }
    return total;
  }

  bool productExist(ProductModel product) {
    return carts.indexWhere((element) => element.product!.id == product.id) !=
        -1;
  }
}
