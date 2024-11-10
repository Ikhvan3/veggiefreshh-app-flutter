import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/repositories/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  // Observable variables
  final Rx<UserModel?> _user = Rx<UserModel?>(null);
  final RxString _token = RxString('');
  final RxBool isLoading = false.obs;

  // Form controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  // Getters
  UserModel? get user => _user.value;
  String get token => _token.value;

  @override
  void onInit() {
    super.onInit();
    getToken();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    usernameController.dispose();
    super.onClose();
  }

  // Menyimpan token
  Future<void> _saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    _token.value = token;
  }

  // Mengambil token
  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token.value = prefs.getString('token') ?? '';
  }

  // Register
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
      await _saveToken(await _authService.getToken() ?? '');

      clearControllers();
      return true;
    } catch (e) {
      print('Error during registration: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Login
  Future<bool> login() async {
    try {
      isLoading.value = true;

      UserModel user = await _authService.login(
        email: emailController.text,
        password: passwordController.text,
      );

      _user.value = user;
      String? token = await _authService.getToken();
      if (token != null) {
        await _saveToken(token);
      }

      clearControllers();
      return true;
    } catch (e) {
      print('Error during login: $e');
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Logout
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    _token.value = '';
    _user.value = null;
  }

  // Clear controllers
  void clearControllers() {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    usernameController.clear();
  }
}
