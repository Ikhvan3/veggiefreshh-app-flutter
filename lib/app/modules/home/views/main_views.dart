import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:veggiefresh/app/modules/home/views/chat/chat_view.dart';
import 'package:veggiefresh/app/modules/home/views/profile/profile_view.dart';
import '../../../core/theme/theme.dart';
import '../controllers/main_controller.dart';
import 'home_view.dart';
import 'wishlist_view.dart';

class MainView extends GetView<MainController> {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget cartButton() {
      return FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          Get.toNamed('/cart'); // Changed to GetX navigation
        },
        backgroundColor: secondaryColor,
        child: Image.asset(
          'assets/icon_cart.png',
          width: 20,
        ),
      );
    }

    Widget customBottomNav() {
      return ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        child: BottomAppBar(
          color: const Color.fromARGB(255, 33, 35, 44),
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          clipBehavior: Clip.antiAlias,
          child: Obx(() => BottomNavigationBar(
                currentIndex: controller.currentIndex.value,
                onTap: (value) {
                  controller.changePage(value);
                },
                backgroundColor: backgroundColor4,
                type: BottomNavigationBarType.fixed,
                elevation: 0,
                items: [
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Image.asset(
                        'assets/icon_home.png',
                        width: 21,
                        color: controller.currentIndex.value == 0
                            ? primaryColor
                            : const Color(0xff808191),
                      ),
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: Image.asset(
                        'assets/icon_chat.png',
                        width: 20,
                        color: controller.currentIndex.value == 1
                            ? primaryColor
                            : const Color(0xff808191),
                      ),
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 50),
                      child: Image.asset(
                        'assets/icon_whislist.png',
                        width: 20,
                        color: controller.currentIndex.value == 2
                            ? primaryColor
                            : const Color(0xff808191),
                      ),
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Image.asset(
                        'assets/icon_profile.png',
                        width: 18,
                        color: controller.currentIndex.value == 3
                            ? primaryColor
                            : const Color(0xff808191),
                      ),
                    ),
                    label: '',
                  ),
                ],
              )),
        ),
      );
    }

    return Obx(() => Scaffold(
          backgroundColor: controller.currentIndex.value == 0
              ? backgroundColor1
              : backgroundColor3,
          floatingActionButton: cartButton(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: customBottomNav(),
          body: IndexedStack(
            index: controller.currentIndex.value,
            children: [
              HomeView(),
              ChatPage(),
              WishlistView(),
              ProfileView(),
            ],
          ),
        ));
  }
}
