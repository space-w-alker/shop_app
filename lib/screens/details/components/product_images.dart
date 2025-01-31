import 'package:flutter/material.dart';
import 'package:shop_app/models/FoodProduct.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key? key,
    required this.product,
  }) : super(key: key);

  final MenuItem product;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenWidth(300),
      child: Stack(
        children: [
          Positioned.fill(
            child: Hero(
              tag: widget.product.uiTag ?? widget.product.id ?? '',
              child: Image.network(
                widget.product.image[selectedImage],
                fit: BoxFit.cover,
            ),
          ),
          ),
          // SizedBox(height: getProportionateScreenWidth(20)),
          Positioned(
              bottom: 10,
              right: 0,
              left: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    widget.product.image.length,
                    (index) => buildSmallProductPreview(index),
                  ),
                ],
              )
           )
        ],
      ),
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(8),
        height: getProportionateScreenWidth(48),
        width: getProportionateScreenWidth(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: Image.network(
          widget.product.image[index],
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
