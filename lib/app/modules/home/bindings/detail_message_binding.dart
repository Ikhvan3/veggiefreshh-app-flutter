import 'package:get/get.dart';
import '../../../data/repositories/message_service.dart';
import '../controllers/chat_detail_controller.dart';

class ChatDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MessageRepository>(() => MessageRepository());
    Get.lazyPut<ChatDetailController>(
      () => ChatDetailController(
          messageRepository: Get.find<MessageRepository>()),
    );
  }
}
