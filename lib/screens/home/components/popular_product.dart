import 'package:flutter/material.dart';
import 'package:shop_app/components/product_card.dart';
import 'package:shop_app/firebase/firestore_service.dart';

import '../../../size_config.dart';
import 'section_title.dart';

class PopularProducts extends StatefulWidget {
  @override
  State<PopularProducts> createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  @override
  Widget build(BuildContext context) {
    return
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: StreamBuilder(
            stream: FirestoreService.getFoodProductSnap(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: snapshot.data!
                      .map((e) => ProductCard(product: e))
                      .toList(),
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
