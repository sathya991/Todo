import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();
  static const _keyUserName = "averylongusernameindeed1234567890";
  static const _keyPassword = "averylongpasswordindeed1234567890";
  static Future setUserName(String username) async =>
      await _storage.write(key: _keyUserName, value: username);
  static Future<String?> getUserName() async =>
      await _storage.read(key: _keyUserName);
  static Future setPassword(String password) async =>
      await _storage.write(key: _keyPassword, value: password);
  static Future<String?> getPassword() async =>
      await _storage.read(key: _keyPassword);
  static Future delete() async => await _storage.deleteAll();
}
