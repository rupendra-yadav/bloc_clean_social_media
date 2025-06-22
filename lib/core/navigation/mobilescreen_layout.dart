import 'package:clean_bloc_wrap/core/variables/global_variables.dart';
import 'package:flutter/material.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreenLayout> {
  int _page = 0;

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: homeScreenItems[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            _page = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: "home",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.search),
            icon: Icon(Icons.search_rounded),
            label: "search",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.add),
            icon: Icon(Icons.add_circle_outline),
            label: "create",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.favorite),
            icon: Icon(Icons.favorite_outline),
            label: "chat",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline),
            label: "profile",
          ),
        ],
      ),
    );
  }
}
