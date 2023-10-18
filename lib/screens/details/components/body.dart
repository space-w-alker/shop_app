import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:shop_app/app_controller.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/firebase/firestore_service.dart';
import 'package:shop_app/models/FoodProduct.dart';
import 'package:shop_app/size_config.dart';

import 'product_description.dart';
import 'top_rounded_container.dart';

class Body extends StatelessWidget {
  final MenuItem product;

  const Body({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final app = Get.find<AppController>();
    return Column(
      children: [
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
                product: product,
                pressOnSeeMore: () {},
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: SizeConfig.screenWidth * 0.15,
                  right: SizeConfig.screenWidth * 0.15,
                  bottom: (40),
                  top: (15),
                ),
                child: DefaultButton(
                  text: "Add To Cart",
                  press: () async {
                    if (app.user.value != null && product.id != null) {
                      await FirestoreService.addToCart(
                        app.user.value!,
                        product.id!,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
