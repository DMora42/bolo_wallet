import 'package:flutter/material.dart';
import '../screens/intro_page.dart';
import '../screens/create_page.dart';
import '../screens/parent_page.dart';
import '../screens/import_page.dart';

Map<String, Widget Function(BuildContext)> getRoutes(context) {
  return {
    '/': (BuildContext context) => const IntroPage(),
    '/create': (BuildContext context) => const CreatePage(),
    '/import': (BuildContext context) => const ImportMnemonicPage(),
    '/parent': (BuildContext context) => const ParentPage(),
  };
}
