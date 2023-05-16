// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'wallet_page.dart';
import 'chart_page.dart';
import 'swap_page.dart';
import 'hub_page.dart';
import 'settings_page.dart';
import '../widgets/navigator/bottom_bar_items.dart';

class ParentPage extends StatefulWidget {
  const ParentPage({Key? key}) : super(key: key);

  @override
  _ParentPageState createState() => _ParentPageState();
}

class _ParentPageState extends State<ParentPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const WalletPage(),
    const ChartPage(),
    /*SwapPage(),
    HubPage(),*/
    const SettingsPage(),
  ];

  final _pageController = PageController(initialPage: 0);
  int maxCount = 5;

  String _appBarTitle = 'Wallet';

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.backgroundColor,
      appBar: AppBar(
        title: Text(_appBarTitle),
        backgroundColor: themeData.backgroundColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(_pages.length, (index) => _pages[index]),
      ),
      extendBody: true,
      bottomNavigationBar: (_pages.length <= maxCount)
          ? AnimatedNotchBottomBar(
              pageController: _pageController,
              color: themeData.cardColor,
              showLabel: false,
              notchColor: themeData.cardColor,
              bottomBarItems: items,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                  switch (_selectedIndex) {
                    case 0:
                      _appBarTitle = 'Wallet';
                      break;
                    case 1:
                      _appBarTitle = 'Chart';
                      break;
                    case 2:
                      _appBarTitle = 'Settings';
                      break;
                  }
                });
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.easeIn,
                );
              },
            )
          : null,
    );
  }
}
