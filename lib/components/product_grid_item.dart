import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shop_app/app_controller.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/firebase/firestore_service.dart';
import 'package:shop_app/models/FoodProduct.dart';
import 'package:badges/badges.dart' as badges;
import 'package:shop_app/screens/details/details_screen.dart';

class ProductGridItem extends StatelessWidget {
  const ProductGridItem({super.key, required this.product});
  final MenuItem product;

  @override
  Widget build(BuildContext context) {
    final app = Get.find<AppController>();
    return Obx(() {
      return badges.Badge(
        position: badges.BadgePosition.topStart(start: 5),
        badgeAnimation: badges.BadgeAnimation.scale(),
        showBadge: app.cart.any((element) => element.productId == product.id),
        badgeContent: Text(
          "${app.cart.firstWhereOrNull((element) => element.productId == product.id)?.numOfItems}",
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.white, fontWeight: FontWeight.w900),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              DetailsScreen.routeName,
              arguments: ProductDetailsArguments(
                  product: product.copyWith(uiTag: '${product.id}menuGrid')),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Hero(
                            tag: '${product.id}menuGrid',
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(200),
                              child: Image.network(
                                product.image[0],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          product.name ?? '[NULL]',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${product.preparationTime ?? '??'} Mins"),
                            buildRating(context),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          "${product.offers?.price} \$",
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18,
                                  ),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: buildLikeButton(context),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () => FirestoreService.addToCart(
                        app.user.value!, product.id!),
                    child: Container(
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(20))),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget buildLikeButton(BuildContext context) {
    final app = Get.find<AppController>();
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: () {
        FirestoreService.addToFavorites(app.user.value!, product.id!,
            remove: app.favorites.contains(product.id!));
      },
      child: Obx(() {
        var isFavorite = app.favorites.contains(product.id);
        return Container(
          padding: EdgeInsets.all((8)),
          height: (28),
          width: (28),
          decoration: BoxDecoration(
            color: isFavorite
                ? kPrimaryColor.withOpacity(0.15)
                : kSecondaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            "assets/icons/Heart Icon_2.svg",
            color: isFavorite ? Color(0xFFFF4848) : Color(0xFFDBDEE4),
          ),
        );
      }),
    );
  }

  Widget buildRating(BuildContext context) {
    return Row(
      children: [
        Text(
          "${product.rating}",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 5),
        SvgPicture.asset("assets/icons/Star Icon.svg"),
      ],
    );
  }
}
