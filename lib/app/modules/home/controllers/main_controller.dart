import 'package:get/get.dart';

class MainController extends GetxController {
  final _selectedIndex = 0.obs;
  get selectedIndex => _selectedIndex.value;
  set selectedIndex(value) => _selectedIndex.value = value;

  void changePage(int index) {
    selectedIndex = index;
  }
}
