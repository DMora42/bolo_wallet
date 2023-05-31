// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class HubPage extends StatefulWidget {
  const HubPage({Key? key}) : super(key: key);

  @override
  _HubPageState createState() => _HubPageState();
}

class _HubPageState extends State<HubPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/peer-to-peer.png'),
        const SizedBox(height: 16),
        const Text(
          'Coming soon',
          style: TextStyle(fontSize: 24),
        ),
      ],
    );
  }
}
