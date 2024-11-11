import 'package:get/get.dart';
import '../../../data/models/message_model.dart';
import '../../../data/models/product_model.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/message_service.dart';

class ChatController extends GetxController {
  final MessageRepository messageRepository;

  ChatController({required this.messageRepository});

  final RxInt currentIndex = 0.obs;
  final Rx<UserModel?> user = Rx<UserModel?>(null);

  Stream<List<MessageModel>> getMessages() {
    return messageRepository.getMessageByUserId(userId: user.value?.id);
  }

  Future<void> sendMessage({
    required String message,
    ProductModel? product,
  }) async {
    if (user.value == null) return;

    await messageRepository.addMessage(
      user: user.value!,
      isFromUser: true,
      message: message,
      product: product,
    );
  }
}
