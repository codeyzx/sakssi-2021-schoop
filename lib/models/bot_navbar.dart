import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:schoop/ui/schoop/activity/activity_page.dart';
import 'package:schoop/ui/schoop/home/home_page.dart';
// import 'package:schoop/ui/schoop/search/search_page.dart';
import 'package:schoop/ui/schoop/profile/profile_page_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:schoop/ui/schoop/sell/sell_page.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentIndex = 0;
  final screens = [
    HomePage(),
    ActivityPage(),
    SellerForm(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.white.withOpacity(0.15),
                spreadRadius: 0,
                blurRadius: 7),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (value) => setState(() => currentIndex = value),
          type: BottomNavigationBarType.fixed,
          backgroundColor: HexColor("#303030"),
          unselectedItemColor: Colors.white,
          selectedItemColor: HexColor("#F2C94C"),
          items: [
            BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.home,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.envelopeOpenText),
              label: "Activity",
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.caretSquareUp),
              label: "Sell",
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.user),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
