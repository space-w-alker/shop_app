import 'package:flutter/material.dart';
import 'package:shop_app/firebase/firestore_service.dart';
import 'package:shop_app/models/FoodCategory.dart';


class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: StreamBuilder<List<FoodCategory>>(
        initialData: [],
        stream: FirestoreService.getFoodCategorySnap(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Row(
              children: snapshot.data
                      ?.map((e) => SpecialOfferCard(
                          category: e.name ?? '[NULL]',
                          image: e.image ?? '',
                          numOfBrands: e.itemsCount ?? 0,
                          press: () {}))
                      .toList() ??
                  [],
            );
          }
          if (snapshot.hasError) {
            return Text(
              snapshot.error.toString(),
              style: TextStyle(color: Colors.red),
            );
          }
          return Text("Loading...");
        },
      ),
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
    required this.numOfBrands,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final int numOfBrands;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: (15)),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: (242),
          height: (100),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF343434).withOpacity(0.4),
                        Color(0xFF343434).withOpacity(0.15),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: (15.0),
                    vertical: (10),
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "$category\n",
                          style: TextStyle(
                            fontSize: (18),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: "$numOfBrands Brands")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
