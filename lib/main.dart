import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'features/auth/domain/usecases/user_repository.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/signup_page.dart';
import 'features/auth/presentation/pages/home_page.dart';
import 'features/auth/presentation/provider/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProviderr(
            SignUpUser(UserRepository()), // Pass your UserRepository instance
            LoginUser(UserRepository()), // Pass your UserRepository instance
            ResetPassword(UserRepository()), // Pass your UserRepository instance
          ),
        ),
      ],
      child: MyApp(startupPage: user != null ? "/home" : "/login"),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String startupPage;

  MyApp({required this.startupPage});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: startupPage,
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}
