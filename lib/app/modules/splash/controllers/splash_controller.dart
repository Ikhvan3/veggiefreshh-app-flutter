import 'package:get/get.dart';
import 'package:veggiefresh/app/routes/app_pages.dart';
import '../../../data/repositories/product_repository.dart';

class SplashController extends GetxController {
  final ProductRepository _productRepository = ProductRepository();
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    initializeApp();
  }

  Future<void> initializeApp() async {
    try {
      // Load initial data
      await _productRepository.getProducts();

      // Add delay for splash screen
      await Future.delayed(Duration(seconds: 1));

      // Navigate to sign in page
      Get.offAllNamed(Routes.AUTHIN);
    } catch (e) {
      print('Error initializing app: $e');
      // You might want to show an error message or handle errors differently
    } finally {
      isLoading.value = false;
    }
  }
}
