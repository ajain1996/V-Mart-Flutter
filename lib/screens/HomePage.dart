import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:v_mart/tabs/home_tab.dart';
import 'package:v_mart/tabs/profile_tab.dart';
import 'package:v_mart/tabs/saved_tab.dart';
import 'package:v_mart/tabs/search_tab.dart';
import 'package:v_mart/widgets/bottom_tabs.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _tabsPagesController;
  int _selectedTab = 0;

  @override
  void initState() {
    _tabsPagesController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPagesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: PageView(
            controller: _tabsPagesController,
            onPageChanged: (num) {
              setState(() {
                _selectedTab = num;
              });
            },
            children: [
              HomeTab(),
              SearchTab(),
              SavedTab(),
              ProfileTab(),
            ],
          ),
        ),
        BottomTabs(
          selectedTab: _selectedTab,
          tabPressed: (num) {
            _tabsPagesController.animateToPage(num,
                duration: Duration(microseconds: 300),
                curve: Curves.easeInCubic);
          },
        )
      ],
    ));
  }
}

// onPressed: () {
//   FirebaseAuth.instance.signOut();
// },
