import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      // ignore: deprecated_member_use
      backgroundColor: themeData.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            /*const Align(
              alignment: Alignment.center,
              child: Image(
                image: AssetImage('/assets/images/'),
              ),
            ),*/
            Container(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Let's get started"),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/create');
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: themeData.brightness == Brightness.light
                      ? Colors.black
                      : Colors.white,
                ),
                child: const Text('Import wallet'),
                onPressed: () {
                  Navigator.of(context).pushNamed('/import');
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
