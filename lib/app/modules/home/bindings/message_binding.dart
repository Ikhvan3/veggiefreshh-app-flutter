import 'package:get/get.dart';
import '../../../data/repositories/message_service.dart';

import '../controllers/message_controller.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MessageRepository>(() => MessageRepository());
    Get.lazyPut<ChatController>(
      () => ChatController(messageRepository: Get.find<MessageRepository>()),
    );
  }
}
