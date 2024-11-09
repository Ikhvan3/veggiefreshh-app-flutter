import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/theme/theme.dart';
import '../../../data/providers/product_provider.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  void initState() {
    // TODO: implement initState
    getInit();
    super.initState();
  }

  getInit() async {
    await Provider.of<ProductProvider>(context, listen: false).getProducts();
    await Future.delayed(
        Duration(seconds: 1)); // Tambahkan delay untuk memastikan data ter-load
    Navigator.pushNamed(context, '/sign-in');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor1,
      body: Center(
        child: Container(
          width: 130,
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/image_splash.png',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
