import 'package:bivouac/components/profile_image.dart';
import 'package:bivouac/screens/main_screens/clan_screen.dart';
import 'package:bivouac/screens/main_screens/explore_screen.dart';
import 'package:bivouac/screens/main_screens/home_screen.dart';
import 'package:bivouac/screens/main_screens/profile_screen.dart';
import 'package:bivouac/theme/color_palet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class ScreenProjector extends StatefulWidget {
  const ScreenProjector({super.key});

  @override
  State<ScreenProjector> createState() => _ScreenProjectorState();
}

class _ScreenProjectorState extends State<ScreenProjector> with TickerProviderStateMixin {
  PersistentTabController controller = PersistentTabController(initialIndex: 0);


  List<Widget> screens = [
    const HomeScreen(),
    const ExploreScreen(),
    const ClanScreen(),
    const ProfileScreen()
  ];

  PersistentBottomNavBarItem navItem(IconData icon, String title){
    return PersistentBottomNavBarItem(
      icon: Icon(icon, size: 30,),
      inactiveIcon: Icon(icon, size: 25,),
      iconAnimationController: AnimationController(vsync: this, duration: const Duration(milliseconds: 400))..forward(),
      title: title,
      activeColorPrimary: Colpal.brown,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
        return [
            navItem(Icons.home, "Home"),
            navItem(Icons.search, "Search"),
            navItem(Icons.group, "Friends"),
            navItem(Icons.person, "Profile"),
        ];
    }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context, 
      screens: screens,
      items: _navBarsItems(),
      hideNavigationBarWhenKeyboardAppears: true,
      navBarHeight: 60,
      navBarStyle: NavBarStyle.style4
      );
  }
}