import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:workmanager/workmanager.dart';
import 'background_worker.dart';
import 'features/auth/domain/usecases/user_repository.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/signup_page.dart';
import 'features/auth/presentation/provider/auth_provider.dart';
import 'features/chat/presentation/pages/home_page.dart';
import 'features/todo/data/repositories/todo_repository.dart';
import 'features/todo/domain/usecases/add_todo.dart';
import 'features/todo/domain/usecases/edit_todo.dart';
import 'features/todo/domain/usecases/get_todos.dart';
import 'features/todo/presentation/provider/todo_provider.dart';

void main() async {
  // Ensure all the necessary bindings are initialized before app startup
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp();
  
  // Initialize WorkManager (for background tasks)
  Workmanager().initialize(callbackDispatcher);

  // Get current authenticated user (if any)
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;

  // Setup the app with providers
  runApp(
    MultiProvider(
     
      providers: [
        ChangeNotifierProvider(
          create: (_) => TodoProvider(
            AddTodo(TodoRepository()), 
            GetTodos(TodoRepository()), 
            EditTodo(TodoRepository()), 
          ),
        ),
        // Register the AuthProvider with necessary use cases
        ChangeNotifierProvider(
          create: (_) => AuthProviderr(
            SignUpUser(UserRepository()), 
            LoginUser(UserRepository()),
            ResetPassword(UserRepository()), 
          ),
        ),
        // You can add other providers here if necessary (e.g., chat, todo)
      ],
      child: MyApp(startupPage: user != null ? "/home" : "/login"), // Set the startup page based on authentication
    ),
  );
}

class MyApp extends StatelessWidget {
  final String startupPage;

  MyApp({required this.startupPage}); // Constructor to accept initial startup route

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // The initial route will either be /home or /login based on user authentication
      initialRoute: startupPage,
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/home': (context) => HomePage(),
        // You can add more routes here for other parts of your app
      },
    );
  }
}
