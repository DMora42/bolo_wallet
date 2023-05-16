import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:provider/provider.dart';
import '../provider/theme/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: CupertinoIcons.pencil_outline,
                  iconStyle: IconStyle(),
                  title: 'Appearance',
                  subtitle: "Feel comfortable here",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.fingerprint,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.red,
                  ),
                  title: 'Security',
                  subtitle: "Protect your assets",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.bolt,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.yellow,
                  ),
                  title: 'Provider',
                  subtitle: "Add another RPC URL",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: themeNotifier.isDark
                      ? Icons.dark_mode_rounded
                      : Icons.light_mode_rounded,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.red,
                  ),
                  title: 'Theme',
                  subtitle: themeNotifier.isDark ? "Dark Mode" : "Light Mode",
                  trailing: Switch.adaptive(
                    value: themeNotifier.isDark,
                    onChanged: (value) {
                      themeNotifier.isDark = value;
                    },
                  ),
                ),
              ],
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: Icons.info_rounded,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.purple,
                  ),
                  title: 'About',
                  subtitle: "Learn more about Bolo Wallet",
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
