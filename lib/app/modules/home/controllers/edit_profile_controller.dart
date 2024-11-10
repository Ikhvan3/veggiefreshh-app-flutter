import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/user_model.dart';
import '../../auth/controllers/auth_controller.dart';

class EditProfileController extends GetxController {
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();

  final Rx<UserModel?> user = Rx<UserModel?>(null);

  @override
  void onInit() {
    super.onInit();
    final authController = Get.find<AuthController>();
    user.value = authController.user;

    // Initialize text controllers with current user data
    nameController.text = user.value?.name ?? '';
    usernameController.text = user.value?.username ?? '';
    emailController.text = user.value?.email ?? '';
  }

  void updateProfile() {
    // Implement profile update logic here
    // You can call your API service and update the user data
    Get.back();
  }

  @override
  void onClose() {
    nameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
