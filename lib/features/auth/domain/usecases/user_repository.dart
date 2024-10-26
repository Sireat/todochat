// user_repository.dart
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUp(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> login(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}


// signup_user.dart
class SignUpUser {
  final UserRepository repository;

  SignUpUser(this.repository);

  Future<void> call(String email, String password) async {
    return repository.signUp(email, password);
  }
}

// login_user.dart
class LoginUser {
  final UserRepository repository;

  LoginUser(this.repository);

  Future<void> call(String email, String password) async {
    return repository.login(email, password);
  }
}

// reset_password.dart
class ResetPassword {
  final UserRepository repository;

  ResetPassword(this.repository);

  Future<void> call(String email) async {
    return repository.resetPassword(email);
  }
}
