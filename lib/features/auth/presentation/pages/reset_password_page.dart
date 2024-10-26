import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';

class ResetPasswordPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final String email = emailController.text.trim();
                if (email.isNotEmpty) {
                  // Trigger password reset function in AuthProvider
                  Provider.of<AuthProviderr>(context, listen: false)
                      .resetPassword(email);
                  // Show confirmation and navigate back
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Password reset link sent to $email")),
                  );
                  Navigator.pop(context);
                } else {
                  // If the email is empty, show a warning
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter a valid email.")),
                  );
                }
              },
              child: const Text("Send Reset Link"),
            ),
          ],
        ),
      ),
    );
  }
}
