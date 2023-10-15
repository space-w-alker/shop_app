import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/home/components/body.dart' as HomeBody;
import 'package:shop_app/screens/profile/components/body.dart' as ProfileBody;

class MainHomeScreen extends StatefulWidget {
  static const routeName = 'main_home';
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  late final PageController controller;
  var pagePosition = 0.0;
  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 0);
    print("Adding Listener");
    controller.addListener(() {
      print(controller.page);
      setState(() {
        pagePosition = controller.page ?? 0.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pagePosition.round(),
        fixedColor: kPrimaryColor,
        unselectedItemColor: Colors.grey[300],
        onTap: (value) {
          controller.animateToPage(value,
              duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
        },
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/Shop Icon.svg",
                color: (pagePosition) < 0.5 ? kPrimaryColor : inActiveIconColor,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/Heart Icon.svg",
                color: (pagePosition) < 1.5 && (pagePosition) > 0.5
                    ? kPrimaryColor
                    : inActiveIconColor,
              ),
              label: "Favorite"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/Chat bubble Icon.svg",
                color: pagePosition < 2.5 && pagePosition > 1.5
                    ? kPrimaryColor
                    : inActiveIconColor,
              ),
              label: "Settings"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/icons/User Icon.svg",
                color: pagePosition < 3.5 && (pagePosition) > 2.5
                    ? kPrimaryColor
                    : inActiveIconColor,
              ),
              label: "Profile"),
        ],
      ),
      body: PageView.builder(
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return HomeBody.Body();
            case 3:
              return ProfileBody.Body();
            default:
              return Center(
                child: Text(""),
              );
          }
        },
        itemCount: 4,
        controller: controller,
      ),
    );
  }
}
