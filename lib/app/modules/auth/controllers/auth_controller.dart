import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/user_model.dart';
import '../../../data/repositories/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  final Rx<UserModel?> _user = Rx<UserModel?>(null);
  final RxString _token = RxString('');
  final RxBool isLoading = false.obs;

  // Text Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final usernameController = TextEditingController();

  UserModel? get user => _user.value;
  String get token => _token.value;

  @override
  void onInit() {
    super.onInit();
    getToken();
  }

  Future<void> getToken() async {
    _token.value = await _authService.getToken() ?? '';
  }

  Future<bool> register() async {
    try {
      isLoading.value = true;

      UserModel user = await _authService.register(
        name: nameController.text,
        username: usernameController.text,
        email: emailController.text,
        password: passwordController.text,
      );

      _user.value = user;
      await getToken();

      return true;
    } catch (e) {
      print('Error during registration: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> login() async {
    try {
      isLoading.value = true;

      UserModel user = await _authService.login(
        email: emailController.text,
        password: passwordController.text,
      );

      _user.value = user;
      await getToken();

      return true;
    } catch (e) {
      print('Error during login: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    _token.value = '';
    _user.value = null;
  }
}
