import 'package:shop_app/models/FoodProduct.dart';


class Cart {
  final FoodProduct product;
  final int numOfItem;

  Cart({required this.product, required this.numOfItem});
}

// Demo data for our cart

List<Cart> demoCarts = [];
