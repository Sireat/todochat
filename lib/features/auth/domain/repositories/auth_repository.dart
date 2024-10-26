import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<User?> signUp(String email, String password);
  Future<User?> login(String email, String password);
  Future<void> resetPassword(String email);
  Future<void> signOut();
  Future<User?> getCurrentUser();
}
