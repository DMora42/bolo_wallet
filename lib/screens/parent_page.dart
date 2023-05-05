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

  List<Widget> _pages = [
    const WalletPage(),
    const ChartPage(),
    /*SwapPage(),
    HubPage(),*/
    SettingsPage(),
  ];

  final _pageController = PageController(initialPage: 1);
  int maxCount = 5;

  String _appBarTitle = 'Wallet'; // Título inicial del AppBar

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
        title: Text(_appBarTitle), // Mostrar el título actual del AppBar
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
              color: Colors.white,
              showLabel: false,
              notchColor: Colors.black87,
              bottomBarItems: items,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                  switch (_selectedIndex) {
                    case 0:
                      _appBarTitle =
                          'Wallet'; // Actualizar el título del AppBar para la pantalla Wallet
                      break;
                    case 1:
                      _appBarTitle =
                          'Chart'; // Actualizar el título del AppBar para la pantalla Chart
                      break;
                    case 2:
                      _appBarTitle =
                          'Settings'; // Actualizar el título del AppBar para la pantalla Settings
                      break;
                  }
                });
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeIn,
                );
              },
            )
          : null,
    );
  }
}
