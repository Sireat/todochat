import '../../domain/repositories/auth_repository.dart';
import '../datasources/firebase_auth_remote_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<User?> signUp(String email, String password) {
    return remoteDataSource.signUpWithEmailPassword(email, password);
  }

  @override
  Future<User?> login(String email, String password) {
    return remoteDataSource.loginWithEmailPassword(email, password);
  }

  @override
  Future<void> resetPassword(String email) {
    return remoteDataSource.resetPassword(email);
  }

  @override
  Future<User?> getCurrentUser() {
    return remoteDataSource.getCurrentUser();
  }

  @override
  Future<void> signOut() {
    return remoteDataSource.signOut();
  }
}
