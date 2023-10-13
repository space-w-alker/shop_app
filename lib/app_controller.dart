import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:shop_app/firebase/auth_service.dart';
import 'package:shop_app/firebase/firestore_service.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/models/User.dart';
import 'package:shop_app/screens/complete_profile/complete_profile_screen.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/screens/sign_in/sign_in_screen.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';

class AppController {
  final RxBool isLoggedIn = RxBool(false);
  final Rx<User?> user = Rx(null);
  final RxList<Cart> cart = RxList([]);
  bool isInitialized = false;

  void initialize(BuildContext context) {
    if (isInitialized) return;
    isInitialized = true;
    StreamSubscription<User?>? subscription;
    StreamSubscription<List<Cart>>? cartSubscription;
    AuthService.getAuthState().listen((u) {
      if (u == null) {
        isLoggedIn.value = false;
        user.value = null;
        subscription?.cancel();
        cartSubscription?.cancel();
        Navigator.pushNamedAndRemoveUntil(context, SignInScreen.routeName,
          (_) => _.settings.name == SplashScreen.routeName,
        );
      } else {
        isLoggedIn.value = true;
        FirestoreService.tryCreateNewUserDocument(u.uid, u.email ?? '');
        cartSubscription = FirestoreService.getUserCart(u.uid).listen((event) {
          cart.value = event;
        });
        subscription =
            FirestoreService.getUserDocumentSnap(u.uid).listen((_user) {
          if (_user?.onBoarded != null && _user?.onBoarded == true) {
            Navigator.pushNamed(
              context,
              HomeScreen.routeName,
            );
          } else {
            Navigator.pushNamed(
              context,
              CompleteProfileScreen.routeName,
            );
          }
          user.value = _user;
        });
      }
    });
  }
}
