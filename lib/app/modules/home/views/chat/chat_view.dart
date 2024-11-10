import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/theme.dart';
import '../../../../data/models/message_model.dart';
import '../../../auth/controllers/auth_controller.dart';
import '../../controllers/main_controller.dart';
import '../../controllers/message_controller.dart';
import '../widgets/chat_tile.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return AppBar(
        backgroundColor: backgroundColor1,
        centerTitle: true,
        title: Text(
          'Message Support',
          style: primaryTextStyle.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      );
    }

    Widget EmptyChat() {
      return Expanded(
        child: Container(
          width: double.infinity,
          color: backgroundColor3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icon_headset.png',
                width: 80,
              ),
              SizedBox(height: 20),
              Text(
                'Opss no message yet?',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: medium,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'You have never done a transaction',
                style: secondaryTextStyle,
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 44,
                child: TextButton(
                  onPressed: () => Get.find<MainController>().changePage(0),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Explore Store',
                    style: primaryTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: medium,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget content() {
      final user = Get.find<AuthController>().user;
      return StreamBuilder<List<MessageModel>>(
        stream: controller.getMessages(user!.id!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return EmptyChat();
            }
            return Expanded(
              child: Container(
                width: double.infinity,
                color: backgroundColor3,
                child: ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: defaultMargin,
                  ),
                  children: [
                    ChatTile(snapshot.data![snapshot.data!.length - 1]),
                  ],
                ),
              ),
            );
          }
          return EmptyChat();
        },
      );
    }

    return Column(
      children: [
        header(),
        content(),
      ],
    );
  }
}
