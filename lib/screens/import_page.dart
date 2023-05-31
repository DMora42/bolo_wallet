// ignore_for_file: unused_field, library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../secure/secure_storage.dart';

class ImportMnemonicPage extends StatefulWidget {
  const ImportMnemonicPage({Key? key}) : super(key: key);

  @override
  _ImportMnemonicPageState createState() => _ImportMnemonicPageState();
}

class _ImportMnemonicPageState extends State<ImportMnemonicPage> {
  bool _isTextVisible = true;
  bool _isMnemonicValid = false;
  final TextEditingController _mnemonicController = TextEditingController();

  void _saveMnemonic() async {
    await SecureStorage().write('mnemonic', _mnemonicController.text);
    Navigator.of(context).pushNamed('/parent');
  }

  void _pasteFromClipboard() async {
    ClipboardData? data = await Clipboard.getData('text/plain');
    if (data != null && data.text != null) {
      final mnemonic = data.text?.trim();
      final words = mnemonic?.split(' ');
      if (words?.length == 12) {
        setState(() {
          _mnemonicController.text = mnemonic!;
          _isMnemonicValid = true;
        });
        return;
      }
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Invalid Mnemonic'),
          content: const Text(
              'The content of the clipboard is not a valid 12-word mnemonic.'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  List<Widget> _buildMnemonicRows(String mnemonic) {
    List<Widget> rows = [];
    List<String> words = mnemonic.split(' ');
    for (int i = 0; i < words.length; i += 4) {
      int end = i + 4;
      if (end > words.length) {
        end = words.length;
      }
      List<String> rowWords = words.sublist(i, end);
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: rowWords.map((word) => Text(word)).toList(),
      ));
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      // ignore: deprecated_member_use
      backgroundColor: themeData.backgroundColor,
      appBar: AppBar(
        title: const Text('Import Mnemonic'),
        // ignore: deprecated_member_use
        backgroundColor: themeData.backgroundColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 32.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Colors.grey.shade400,
                  width: 2.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _buildMnemonicRows(_mnemonicController.text),
              ),
            ),
            const SizedBox(height: 16.0),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isTextVisible = false;
                });
                _pasteFromClipboard();
                Future.delayed(const Duration(milliseconds: 500), () {
                  _saveMnemonic();
                });
              },
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.blue,
                ),
                child: const Text(
                  'Paste your mnemonic here',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _isMnemonicValid ? _saveMnemonic : null,
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
