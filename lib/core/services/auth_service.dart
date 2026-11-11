import 'package:flutter/foundation.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String? photoUrl;
  final bool isGoogleUser;

  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.photoUrl,
    this.isGoogleUser = false,
  });
}

class RegisteredAccount {
  final String name;
  final String email;
  final String password;
  final String? photoUrl;

  RegisteredAccount({
    required this.name,
    required this.email,
    required this.password,
    this.photoUrl,
  });
}

class AuthResult {
  final bool success;
  final String message;

  AuthResult({required this.success, required this.message});
}

class AuthService extends ValueNotifier<UserModel?> {
  AuthService._internal() : super(null) {
    // Pre-register default account zaeem@gmail.com
    _registeredAccounts['zaeem@gmail.com'] = RegisteredAccount(
      name: 'Zaeem',
      email: 'zaeem@gmail.com',
      password: 'password123',
    );
  }

  static final AuthService instance = AuthService._internal();

  final Map<String, RegisteredAccount> _registeredAccounts = {};

  bool get isLoggedIn => value != null;

  Future<AuthResult> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    final cleanEmail = email.trim().toLowerCase();

    if (_registeredAccounts.containsKey(cleanEmail)) {
      return AuthResult(
        success: false,
        message: "Account already exists with this email. Please login instead.",
      );
    }

    final account = RegisteredAccount(
      name: name.trim().isNotEmpty ? name.trim() : 'User',
      email: email.trim(),
      password: password,
      photoUrl: null, // No photo -> shows user icon
    );
    _registeredAccounts[cleanEmail] = account;

    value = UserModel(
      uid: DateTime.now().millisecondsSinceEpoch.toString(),
      name: account.name,
      email: account.email,
      photoUrl: null,
      isGoogleUser: false,
    );

    return AuthResult(
      success: true,
      message: "Signup successful! Welcome, ${account.name}",
    );
  }

  Future<AuthResult> loginWithEmail({
    required String email,
    required String password,
  }) async {
    final cleanEmail = email.trim().toLowerCase();

    // Verify against Registered Accounts Database
    if (!_registeredAccounts.containsKey(cleanEmail)) {
      return AuthResult(
        success: false,
        message: "Wrong credentials! Account does not exist. Please signup first.",
      );
    }

    final account = _registeredAccounts[cleanEmail]!;
    if (account.password != password) {
      return AuthResult(
        success: false,
        message: "Wrong credentials! Incorrect email or password.",
      );
    }

    value = UserModel(
      uid: DateTime.now().millisecondsSinceEpoch.toString(),
      name: account.name,
      email: account.email,
      photoUrl: account.photoUrl,
      isGoogleUser: false,
    );

    return AuthResult(
      success: true,
      message: "Login successful! Welcome back, ${account.name}",
    );
  }

  Future<UserModel?> loginWithGoogleFirebase() async {
    return null;
  }

  void loginWithCustomUser({
    required String name,
    required String email,
    String? photoUrl,
    bool isGoogle = false,
  }) {
    value = UserModel(
      uid: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      photoUrl: photoUrl,
      isGoogleUser: isGoogle,
    );
  }

  void logout() {
    value = null;
  }
}
