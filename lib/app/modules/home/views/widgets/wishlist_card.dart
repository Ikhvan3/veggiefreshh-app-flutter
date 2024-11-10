import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../core/theme/theme.dart';
import '../../../../data/models/product_model.dart';
import '../../controllers/wishlist_controller.dart';

class WishListCard extends StatelessWidget {
  final ProductModel product;
  WishListCard(this.product);

  @override
  Widget build(BuildContext context) {
    final WishlistController wishlistController = Get.find();

    return Container(
      margin: EdgeInsets.only(
        top: 20,
      ),
      padding: EdgeInsets.only(
        top: 10,
        bottom: 14,
        left: 12,
        right: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          12,
        ),
        color: backgroundColor4,
      ),
      child: Row(
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
                  print('Error loading image: $error');
                  return Image.asset(
                    'assets/image_shoes.png',
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(child: CircularProgressIndicator());
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
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(12),
          //   child: Image.network(
          //     product.galleries![1].url!,
          //     width: 60,
          //   ),
          // ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name!,
                  style: primaryTextStyle.copyWith(
                    fontWeight: semiBold,
                  ),
                ),
                Text(
                  '\$${product.price}',
                  style: priceTextStyle,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              wishlistController.toggleWishlist(product);
            },
            child: Image.asset(
              'assets/button_wishlist_blue.png',
              width: 34,
            ),
          ),
        ],
      ),
    );
  }
}
