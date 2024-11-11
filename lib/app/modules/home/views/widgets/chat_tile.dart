import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veggiefresh/app/modules/home/views/chat/chat_detail_view.dart';
import '../../../../core/theme/theme.dart';
import '../../../../data/models/message_model.dart';
import '../../../../data/models/product_model.dart';

class ChatTile extends StatelessWidget {
  final MessageModel message;
  ChatTile(this.message);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => DetailChatView());
      },
      child: Container(
        margin: EdgeInsets.only(top: 33),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset('assets/icon_shop_logo.png', width: 54),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Shoe Store',
                          style: primaryTextStyle.copyWith(fontSize: 15)),
                      Text(
                        message.message!,
                        style: secondaryTextStyle.copyWith(fontWeight: light),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Text('Now', style: secondaryTextStyle.copyWith(fontSize: 12)),
              ],
            ),
            SizedBox(height: 16),
            Divider(
              thickness: 1,
              color: Color(0xff2B2939),
            ),
          ],
        ),
      ),
    );
  }
}
