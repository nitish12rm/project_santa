import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_santa/core/utils/command.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/utils/result.dart';
import '../../../../data/repository/auth/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  User? _user;
  String? _error;
  Stream<User?> get authStateChanges => _authRepository.userStream;

  AuthViewModel({required AuthRepository authRepository})
      : _authRepository = authRepository {
    // Attempt to sign in with saved credentials
    _attemptAutoSignIn();

    _authRepository.userStream.listen((user) {
      _user = user;
      notifyListeners();
    });

    // Initialize commands
    signInCommand = Command2<Result<void>, String, String>(
          (email, password) async {
        final result = await _authRepository.signIn(email, password);
        switch (result) {
          case Ok<User?>():
            log("auth_VM_success");
            _saveCredentials(email, password); // Save credentials on successful sign-in
            return Result.ok(null);

          case Error<User?>():
            log("auth_VM_error ${result.error}");
            _error = result.error.toString();
            return Result.error(result.error);
        }
        return Result.ok(null);  // Corrected to return Result.ok with null for void result
      },
    );

    registerCommand = Command1<Result<void>, Map<String,String>>(
          (data) async {
        final result = await _authRepository.register(data);
        switch (result) {
          case Ok<User?>():
            _saveCredentials(data['email']!, data['password']!); // Save credentials on successful registration
            return Result.ok(null);
          case Error<User?>():
            _error = result.error.toString();
            return Result.error(result.error);
        }
      },
    );

    signOutCommand = Command0<Result<void>>(
            () async {
          final result = await _authRepository.signOut();
          switch (result) {
            case Ok():
              await _clearCredentials(); // Clear credentials on sign-out
              return Result.ok(null);
            case Error():
              _error = result.error.toString();
              return Result.error(result.error);
          }
        });
  }

  User? get user => _user;
  String? get error => _error;

  // Command definitions
  late final Command2<Result<void>, String, String> signInCommand;
  late final Command1<Result<void>, Map<String, String>> registerCommand;
  late final Command0<Result<void>> signOutCommand;

  bool get isLoggedIn => _user != null;

  // Save email and password to SharedPreferences
  Future<void> _saveCredentials(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  // Clear credentials from SharedPreferences
  Future<void> _clearCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('password');
  }

  // Method to retrieve saved credentials (if needed)
  Future<Map<String, String?>> getSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    final password = prefs.getString('password');
    return {'email': email, 'password': password};
  }

  // Attempt auto sign-in with saved credentials
  Future<void> _attemptAutoSignIn() async {
    final credentials = await getSavedCredentials();
    final email = credentials['email'];
    final password = credentials['password'];

    if (email != null && password != null) {
      final result = await _authRepository.signIn(email, password);
      if (result is Ok<User?>) {
        log("Auto sign-in successful");

      } else {
        log("Auto sign-in failed");
      }
    } else {
      log("No saved credentials found");
    }
  }
}
