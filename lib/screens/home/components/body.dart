import 'package:flutter/material.dart';
import 'package:shop_app/components/product_grid_item.dart';
import 'package:shop_app/firebase/firestore_service.dart';
import 'package:shop_app/models/FoodProduct.dart';
import 'package:shop_app/screens/home/components/section_title.dart';

import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'special_offers.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: (20))),
          SliverToBoxAdapter(child: HomeHeader()),
          SliverToBoxAdapter(child: SizedBox(height: (10))),
          SliverToBoxAdapter(child: DiscountBanner()),
          SliverToBoxAdapter(child: Categories()),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SectionTitle(
                title: "Featured Categories",
                press: () {},
              ),
            ),
          ),
          SliverToBoxAdapter(child: SpecialOffers()),
          SliverToBoxAdapter(child: SizedBox(height: (30))),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SectionTitle(
                title: "Popular Products",
                press: () {},
              ),
            ),
          ),
          SliverToBoxAdapter(child: PopularProducts()),
          SliverToBoxAdapter(child: SizedBox(height: (30))),
          SliverToBoxAdapter(child: SizedBox(height: (30))),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SectionTitle(
                title: "Menu",
                press: () {},
              ),
            ),
          ),
          StreamBuilder<List<MenuItem>>(
              stream: FirestoreService.getFoodProductSnap(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SliverGrid.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ProductGridItem(product: snapshot.data![index]),
                      );
                    },
                    itemCount: snapshot.data!.length,
                  );
                }
                if (snapshot.hasError) {
                  return SliverToBoxAdapter(
                    child: Text(
                      snapshot.error.toString(),
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }
                return SliverToBoxAdapter(
                  child: Text('Loading...'),
                );
              })
        ],
      ),
    );
  }
}
