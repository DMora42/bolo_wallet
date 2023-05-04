import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'wallet_page.dart';
import 'chart_page.dart';
import 'swap_page.dart';
import 'hub_page.dart';
import 'settings_page.dart';

class ParentPage extends StatefulWidget {
  const ParentPage({Key? key}) : super(key: key);

  @override
  _ParentPageState createState() => _ParentPageState();
}

class _ParentPageState extends State<ParentPage> {
  int _selectedIndex = 0;

  List<Widget> _pages = [
    WalletPage(),
    ChartPage(),
    /*SwapPage(),
    HubPage(),
    SettingsPage(),*/
  ];

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.wallet, color: Colors.black),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.chartSimple, color: Colors.black),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.rightLeft, color: Colors.black),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.users, color: Colors.black),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.gear, color: Colors.black),
      label: '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.backgroundColor,
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
