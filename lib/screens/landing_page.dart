import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:prophunter/screens/home_screen/home_screen.dart';
import 'package:prophunter/screens/profile/profile.dart';
import 'package:prophunter/screens/search_screen/search_screen.dart';

import '../../constant.dart';
import '../../size_config.dart';
import '../services/getData.dart';

class LandingPage extends StatefulWidget {
  static String routeName = "/landing_screen";

  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  Future<bool> _willPopCallback(context) async {
    return Future.value(true);
  }

  @override
  void initState() {
    SendData().getStatus(context);
    SendData().getCommunity(context);
    SendData().getBanner(context);
    SendData().getFeaturedCommunity(context);
    SendData().getPropertyType(context);
    SendData().getProperty(context);
    SendData().getTopPicks(context);
    SendData().getUser(context);
    SendData().getMinMax(context);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return PersistentTabView(
      context,
      controller: _controller,
      // handleAndroidBackButtonPress: false,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.black,
      // onWillPop: _willPopCallback,
      // Default is Colors.white.
      handleAndroidBackButtonPress: true,
      // Default is true.
      resizeToAvoidBottomInset: true,
      // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true,
      // Default is true.
      hideNavigationBarWhenKeyboardShows: true,

      // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.black,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),

      navBarStyle: NavBarStyle.style2, // Choose the nav bar style with this property.
    );
  }

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const SearchScreen(),
      const Profile(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: kSecondaryColor,
        inactiveColorPrimary: fadeWhite,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.search),
        title: ("Search"),
        activeColorPrimary: kSecondaryColor,
        inactiveColorPrimary: fadeWhite,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person),
        title: ("Profile"),
        activeColorPrimary: kSecondaryColor,
        inactiveColorPrimary: fadeWhite,
      ),
    ];
  }
}
