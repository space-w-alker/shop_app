import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:shop_app/app_controller.dart';
import 'package:shop_app/firebase/firestore_service.dart';

import '../../../size_config.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    final app = Get.find<AppController>();
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Obx(() {
        return ListView.builder(
          itemCount: app.cart.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: StreamBuilder(
              key: ValueKey(app.cart[index].productId),
              stream: FirestoreService.getOneProductSnap(
                  app.cart[index].productId ?? ''),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var product = snapshot.data!;
                  return Dismissible(
                    key: Key(app.cart[index].productId ?? ''),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() {
                        app.cart.removeAt(index);
                      });
                    },
                    background: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFE6E6),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Spacer(),
                          SvgPicture.asset("assets/icons/Trash.svg"),
                        ],
                      ),
                    ),
                    child: CartCard(
                      numOfItems: app.cart[index].numOfItems ?? 0,
                      product: product,
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return Text(
                    snapshot.error.toString(),
                    style: TextStyle(color: Colors.red),
                  );
                }
                return Text("Loading");
              },
            ),
          ),
        );
      }),
    );
  }
}
