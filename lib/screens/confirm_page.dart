import 'package:flutter/material.dart';
import '../secure/secure_storage.dart';

class ConfirmMnemonicPage extends StatefulWidget {
  final List<String> words;
  const ConfirmMnemonicPage({required this.words, Key? key}) : super(key: key);

  @override
  _ConfirmMnemonicPageState createState() => _ConfirmMnemonicPageState();
}

class _ConfirmMnemonicPageState extends State<ConfirmMnemonicPage> {
  List<String> selectedWords = List.filled(12, '');

  bool get isConfirmed {
    for (int i = 0; i < widget.words.length; i++) {
      if (widget.words[i] != selectedWords[i]) {
        return false;
      }
    }
    return true;
  }

  Future<void> navigateTo() async {
    Navigator.of(context).pushNamed('/parent');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please confirm your 12-word mnemonic phrase:',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(
                widget.words.length,
                (index) => GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return ListView.builder(
                          itemCount: 12,
                          itemBuilder: (context, i) {
                            return ListTile(
                              title: Text(
                                widget.words[i],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: selectedWords[i].isEmpty
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  selectedWords[index] = widget.words[i];
                                });
                                Navigator.pop(context);
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                  child: Chip(
                    label: Text(selectedWords[index].isEmpty
                        ? '?'
                        : selectedWords[index]),
                    backgroundColor: Colors.grey[300],
                  ),
                ),
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: isConfirmed
                  ? () async {
                      final mnemonic = widget.words.join(' ');
                      await SecureStorage().write('mnemonic', mnemonic);
                      await navigateTo();
                    }
                  : null,
              child: Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}
