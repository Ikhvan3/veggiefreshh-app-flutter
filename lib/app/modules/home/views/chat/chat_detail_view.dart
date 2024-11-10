import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/theme.dart';
import '../../../../data/models/message_model.dart';
import '../../../../data/models/product_model.dart';
import '../../../auth/controllers/auth_controller.dart';
import '../../controllers/message_controller.dart';
import '../widgets/chat_bubble.dart';

class ChatDetailView extends GetView<ChatController> {
  const ChatDetailView({Key? key}) : super(key: key);

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
            SizedBox(width: 12),
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
                )
              ],
            ),
          ],
        ),
        toolbarHeight: 70,
      );
    }

    Widget productPreview() {
      return Obx(() {
        final product = controller.product.value;
        if (product is UninitializedProductModel) {
          return SizedBox();
        }

        return Container(
          width: 225,
          height: 74,
          margin: EdgeInsets.only(bottom: 20),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: backgroundColor5,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: primaryColor),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (product.galleries!.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    product.galleries![0].url!,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/image_shoes.png',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                )
              else
                Image.asset(
                  'assets/image_shoes.png',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name!,
                      style: primaryTextStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2),
                    Text(
                      '\$${product.price}',
                      style: priceTextStyle.copyWith(
                        fontWeight: medium,
                      ),
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
        margin: EdgeInsets.all(20),
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
                    padding: EdgeInsets.symmetric(horizontal: 16),
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
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    final user = Get.find<AuthController>().user;
                    controller.sendMessage(
                      user: user!,
                      message: controller.messageController.text,
                      product: controller.product.value,
                    );
                  },
                  child: Image.asset(
                    'assets/button_send.png',
                    width: 45,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget content() {
      final user = Get.find<AuthController>().user;
      return StreamBuilder<List<MessageModel>>(
        stream: controller.getMessages(user!.id!),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No messages yet'),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.symmetric(
              horizontal: defaultMargin,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              MessageModel message = snapshot.data![index];
              return ChatBubble(
                isSender: message.isFromUser!,
                text: message.message!,
                product: message.product,
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
