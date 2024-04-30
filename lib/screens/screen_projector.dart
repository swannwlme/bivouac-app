import 'package:bivouac/components/profile_image.dart';
import 'package:bivouac/screens/main_screens/home_screen.dart';
import 'package:bivouac/theme/color_palet.dart';
import 'package:flutter/material.dart';

class ScreenProjector extends StatefulWidget {
  const ScreenProjector({super.key});

  @override
  State<ScreenProjector> createState() => _ScreenProjectorState();
}

class _ScreenProjectorState extends State<ScreenProjector> {
  int selectedScreen = 0;

  List screens = [
    const HomeScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colpal.brown,
        showUnselectedLabels: false,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600
        ),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Clan',
          ),
          BottomNavigationBarItem(
            icon: ProfileImage(size: 13,),
            label: 'Profile',
          )
        ],
        currentIndex: selectedScreen,
        onTap: (index) {
          setState(() {
            selectedScreen = index;
          });
        },
      ),
      body: selectedScreen>=0 && selectedScreen<screens.length ? screens[selectedScreen] : screens[0],
    );
  }
}