import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/theme.dart';
import '../../../../data/models/message_model.dart';
import '../../../../data/models/product_model.dart';
import '../../../auth/controllers/auth_controller.dart';
import '../../controllers/chat_detail_controller.dart';
import '../widgets/chat_bubble.dart';

class DetailChatView extends GetView<ChatDetailController> {
  const DetailChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget header() {
      return AppBar(
        backgroundColor: backgroundColor1,
        centerTitle: false,
        title: Row(
          children: [
            Image.asset(
              'assets/image_shop_logo_online.png',
              width: 50,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shoe Store',
                  style: primaryTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Online',
                  style: secondaryTextStyle.copyWith(
                    fontWeight: light,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget productPreview() {
      return Obx(() {
        final currentProduct = controller.product.value;
        if (currentProduct == null ||
            currentProduct is UninitializedProductModel) {
          return const SizedBox();
        }

        return Container(
          width: 225,
          height: 74,
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: backgroundColor5,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: primaryColor),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: currentProduct.galleries?.isNotEmpty == true
                    ? Image.network(
                        currentProduct.galleries![0].url!,
                        width: 54,
                        height: 54,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/image_shoes.png',
                            width: 54,
                            height: 54,
                            fit: BoxFit.cover,
                          );
                        },
                      )
                    : Image.asset(
                        'assets/image_shoes.png',
                        width: 54,
                        height: 54,
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      currentProduct.name ?? '',
                      style: primaryTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '\$${currentProduct.price}',
                      style: priceTextStyle.copyWith(fontWeight: medium),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: controller.clearProduct,
                child: Image.asset(
                  'assets/button_close.png',
                  width: 22,
                ),
              ),
            ],
          ),
        );
      });
    }

    Widget chatInput() {
      return Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            productPreview(),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: backgroundColor4,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: TextFormField(
                        controller: controller.messageController,
                        style: primaryTextStyle,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Type Message...',
                          hintStyle: subtitleTextStyle,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                GetBuilder<ChatDetailController>(
                  builder: (controller) => GestureDetector(
                    onTap: () {
                      if (controller.messageController.text.isNotEmpty) {
                        final user = Get.find<AuthController>().user?.value;
                        if (user != null) {
                          controller.sendMessage(
                            user: user,
                            message: controller.messageController.text,
                            product: controller.product.value,
                          );
                        }
                      }
                    },
                    child: Image.asset(
                      'assets/button_send.png',
                      width: 45,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget content() {
      return GetBuilder<AuthController>(
        builder: (authController) {
          final user = authController.user?.value;
          if (user == null) {
            return const Center(child: Text('Please login to continue'));
          }

          return StreamBuilder<List<MessageModel>>(
            stream: controller.getMessages(user.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No messages yet'));
              }

              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final message = snapshot.data![index];
                  return ChatBubble(
                    isSender: message.isFromUser!,
                    text: message.message!,
                    product: message.product,
                  );
                },
              );
            },
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor3,
      appBar: header(),
      bottomNavigationBar: chatInput(),
      body: content(),
    );
  }
}
