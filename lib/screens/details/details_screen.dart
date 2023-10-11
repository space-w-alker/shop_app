import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/FoodProduct.dart';
import 'package:shop_app/screens/details/components/product_images.dart';
import 'package:shop_app/size_config.dart';

import 'components/body.dart';
import 'components/custom_app_bar.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments agrs =
        ModalRoute.of(context)!.settings.arguments as ProductDetailsArguments;
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: SizedBox(
              height: getProportionateScreenWidth(20),
              width: getProportionateScreenWidth(20),
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                  primary: kPrimaryColor,
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.zero,
                ),
                onPressed: () => Navigator.pop(context),
                child: SvgPicture.asset(
                  "assets/icons/Back ICon.svg",
                  height: 15,
                ),
              ),
            ),
            actions: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Text(
                      "${agrs.product.rating}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 5),
                    SvgPicture.asset("assets/icons/Star Icon.svg"),
                  ],
                ),
              )
            ],
            expandedHeight: 300,
            flexibleSpace: ProductImages(product: agrs.product),
          ),
          SliverToBoxAdapter(
            child: Body(product: agrs.product),
          )
        ],
      ),
    );
  }
}

class ProductDetailsArguments {
  final FoodProduct product;

  ProductDetailsArguments({required this.product});
}
