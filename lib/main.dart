import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import 'app/core/utils/image_url_helper.dart';
import 'app/modules/cart/controllers/cart_controller.dart';
import 'app/routes/app_pages.dart';
import 'firebase_options.dart';

Future<void> validateConnections() async {
  try {
    print('Testing API connection...');
    final response = await http.get(Uri.parse(AppConfig.baseUrl));
    print('Base URL (${AppConfig.baseUrl}) response: ${response.statusCode}');

    final apiResponse =
        await http.get(Uri.parse('${AppConfig.apiUrl}/products'));
    print(
        'API URL (${AppConfig.apiUrl}/products) response: ${apiResponse.statusCode}');
  } catch (e) {
    print('Connection test error: $e');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform, // Gunakan options dari firebase_options.dart
  );
  Get.put<CartController>(CartController(), permanent: true);
  runApp(
    GetMaterialApp(
      title: "Application",
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.SPLASH,
      getPages: AppPages.routes,
    ),
  );
}
