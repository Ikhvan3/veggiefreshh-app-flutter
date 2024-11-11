import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/message_model.dart';
import '../../../data/models/product_model.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/message_service.dart';

class ChatDetailController extends GetxController {
  final MessageRepository messageRepository;
  ChatDetailController({required this.messageRepository});

  final TextEditingController messageController = TextEditingController();
  final Rx<ProductModel?> product = Rx<ProductModel?>(null);

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }

  Stream<List<MessageModel>> getMessages(int userId) {
    return messageRepository.getMessageByUserId(userId: userId);
  }

  Future<void> sendMessage({
    required UserModel user,
    required String message,
    ProductModel? product,
  }) async {
    try {
      await messageRepository.addMessage(
        user: user,
        isFromUser: true,
        message: message,
        product: product,
      );
      messageController.clear();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal mengirim pesan',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void clearProduct() {
    product.value = UninitializedProductModel();
  }
}
