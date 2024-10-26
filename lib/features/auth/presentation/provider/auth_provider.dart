import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/usecases/user_repository.dart';

class AuthProviderr with ChangeNotifier {
  final SignUpUser signUpUser;
  final LoginUser loginUser;
  final ResetPassword resetPasswordUseCase; // Renamed to avoid conflict

  AuthProviderr(this.signUpUser, this.loginUser, this.resetPasswordUseCase);

  Future<bool> login(String email, String password) async {
    try {
      await loginUser.call(email, password);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> signUp(String email, String password) async {
    await signUpUser.call(email, password);
  }

  Future<void> resetPassword(String email) async {
    await resetPasswordUseCase.call(email); // Use the renamed variable
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
