import 'package:get/get.dart';
import '../../../data/models/user_model.dart';
import '../../auth/controllers/auth_controller.dart';

class ProfileController extends GetxController {
  final Rx<UserModel?> user = Rx<UserModel?>(null);

  @override
  void onInit() {
    super.onInit();
    // Get user data from AuthController
    final authController = Get.find<AuthController>();
    user.value = authController.user;
  }

  void logout() {
    final authController = Get.find<AuthController>();
    authController.logout();
    Get.offAllNamed('/sign-in');
  }
}
