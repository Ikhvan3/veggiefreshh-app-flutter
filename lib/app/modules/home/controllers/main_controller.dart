import 'package:get/get.dart';

class MainController extends GetxController {
  // Observable variable untuk current index
  RxInt currentIndex = 0.obs;

  // Method untuk mengubah halaman
  void changePage(int index) {
    currentIndex.value = index;
  }
}
