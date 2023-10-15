import 'package:flutter/material.dart';
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
        ],
      ),
    );
  }
}
