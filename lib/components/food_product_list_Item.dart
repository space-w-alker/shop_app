import 'package:flutter/material.dart';
import 'package:shop_app/models/FoodProduct.dart';

class FoodProductListItem extends StatelessWidget {
  const FoodProductListItem({super.key, required this.product});

  final FoodProduct product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: AspectRatio(
        aspectRatio: 1,
        child: Column(
          children: [
            Expanded(child: Image.network(product.images[0])),
          ],
        ),
      ),
    );
  }
}
