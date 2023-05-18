import 'dart:async';
import 'package:bolo_wallet/data/theme_data.dart';
import 'package:bolo_wallet/provider/theme/theme_provider.dart';
import 'package:bolo_wallet/routes/routes.dart';
import 'package:bolo_wallet/secure/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isMnemonicStored = false;

  @override
  void initState() {
    super.initState();
    _isMnemonic();
    //  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //      overlays: [SystemUiOverlay.top]);
  }

  Future<void> _isMnemonic() async {
    final mnemonic = await SecureStorage().read('mnemonic');
    setState(() {
      _isMnemonicStored = mnemonic!.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ModelTheme(),
        child: Consumer<ModelTheme>(
            builder: (context, ModelTheme themeNotifier, child) {
          return Sizer(builder: (context, orientation, deviceType) {
            return GetMaterialApp(
              defaultTransition: Transition.rightToLeft,
              transitionDuration: const Duration(milliseconds: 500),
              debugShowCheckedModeBanner: false,
              title: 'Bolo Wallet',
              initialRoute: _isMnemonicStored ? '/parent' : '/',
              routes: getRoutes(context),
              theme: themeNotifier.isDark
                  ? Constants.darkModeTheme
                  : Constants.lightModeTheme,
            );
          });
        }));
  }
}
