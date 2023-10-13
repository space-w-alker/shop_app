import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:shop_app/app_controller.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/FoodProduct.dart';
import 'package:shop_app/size_config.dart';

import 'color_dots.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatelessWidget {
  final FoodProduct product;

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
              TopRoundedContainer(
                color: Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.15,
                          right: SizeConfig.screenWidth * 0.15,
                          bottom: getProportionateScreenWidth(40),
                          top: getProportionateScreenWidth(15),
                        ),
                          child: DefaultButton(
                            text: "Add To Cart",
                            press: () {
                              for (var i = 0; i < app.cart.length; i++) {
                                final cartItem = app.cart[i];
                                if (cartItem.product.id == product.id) {
                                  app.cart[i] = Cart(
                                      product: product,
                                      numOfItem: cartItem.numOfItem + 1);
                                  app.cart.refresh();
                                  return;
                                }
                              }
                              app.cart
                                  .add(Cart(product: product, numOfItem: 1));
                            },
                          )
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
