import 'package:get/get.dart';
import 'package:veggiefresh/app/modules/auth/controllers/auth_controller.dart';
import 'package:veggiefresh/app/modules/home/controllers/message_controller.dart';

class MessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(
      () => ChatController(),
    );
    Get.lazyPut<AuthController>(
      () => AuthController(),
    );
  }
}
