import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot password?', style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
           const SizedBox(height: 20),
            const Text(
              'Enter the email address you signed up with and we will send you a link to reset your password.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold), 
            ),
            const SizedBox(height: 160),
            TextField( 
              
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                filled: true, fillColor: Colors.white,
                labelText: 'Email Address', labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement sending the password reset email
                String email = emailController.text;
                // TODO: Add your password reset logic here
              },
              style: ElevatedButton.styleFrom(
                 backgroundColor: const Color.fromARGB(255, 18, 62, 97), // Background color
              ),
              child: const Text('Send Reset Link', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
