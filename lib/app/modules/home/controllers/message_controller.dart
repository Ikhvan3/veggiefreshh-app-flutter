import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/message_model.dart';
import '../../../data/models/product_model.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/message_service.dart';

class ChatController extends GetxController {
  final MessageService _messageService = MessageService();
  final messageController = TextEditingController();

  var messages = <MessageModel>[].obs;
  var product = UninitializedProductModel().obs;

  Stream<List<MessageModel>> getMessages(int userId) {
    return _messageService.getMessageByUserId(userId: userId);
  }

  Future<void> sendMessage({
    required UserModel user,
    required String message,
    ProductModel? product,
  }) async {
    try {
      await _messageService.addMessage(
        user: user,
        isFromUser: true,
        message: message,
        product: product,
      );
      messageController.clear();
      if (product != null) {
        this.product.value = UninitializedProductModel();
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send message',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void clearProduct() {
    product.value = UninitializedProductModel();
  }
}
