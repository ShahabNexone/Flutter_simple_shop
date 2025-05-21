import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../config/secure_config.dart';

class AuthService {
  static Future<bool> login(String username, String password) async {
    // Hash the password using SHA-256
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    
    return username == SecureConfig.adminUsername && 
           digest.toString() == SecureConfig.adminPasswordHash;
  }

  static bool isLoggedIn() {
    // This will be implemented with a state management solution
    return false;
  }

  static void logout() {
    // This will be implemented with a state management solution
  }
}
