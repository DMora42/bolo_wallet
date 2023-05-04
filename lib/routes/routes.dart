import 'package:flutter/material.dart';
import '../screens/intro_page.dart';
import '../screens/create_page.dart';
import '../screens/parent_page.dart';
import '../screens/import_page.dart';

Map<String, Widget Function(BuildContext)> getRoutes(context) {
  return {
    '/': (BuildContext context) => IntroPage(),
    '/create': (BuildContext context) => CreatePage(),
    '/import': (BuildContext context) => ImportMnemonicPage(),
    '/parent': (BuildContext context) => ParentPage(),
  };
}
