import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  // ignore: prefer_const_constructors
  final storage = FlutterSecureStorage();

  Future<void> write(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future<String?> read(String key) async {
    final String? value = await storage.read(key: key);
    return value;
  }

  Future<Map<String, String>> readAll() async {
    Map<String, String> allValues = await storage.readAll();
    return allValues;
  }

  Future<void> delete(String key) async {
    await storage.delete(key: key);
  }

  Future<void> deleteAll() async {
    await storage.deleteAll();
  }
}
