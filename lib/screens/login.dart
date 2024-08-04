import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopbystock/screens/background.dart';
import 'face_id.dart';  // Ensure this path is correct

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final Authentication auth = Authentication(); // Instance of Authentication for biometric login

    Future<void> login() async {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        Navigator.pushNamed(context, '/home'); // Navigate to the home screen on success
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to login: ${e.message}')),
        );
      }
    }

    Future<void> loginWithFaceId() async {
      bool isAuthenticated = await auth.authenticateWithBiometrics();
      if (isAuthenticated) {
        Navigator.pushNamed(context, '/home'); // Navigate to the home screen on successful Face ID authentication
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Face ID authentication failed')),
        );
      }
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 22, 98, 160),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 8, 114, 220),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushNamed(context, '/main'),
        ),
        title: Image.asset(
          'assets/images/shopby.png',
          fit: BoxFit.cover,
          height: 250,
        ),
      ),
      body: Container(
        decoration: backgroundImageBoxDecoration(),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: '📧Enter Email:',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: Color.fromARGB(255, 3, 25, 41)),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Enter password:',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: const BorderSide(color: Color.fromARGB(255, 3, 25, 41)),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 18, 62, 97),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: const Text('Login🔑'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: loginWithFaceId,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: const Text('Login with Face ID'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/passwrd');
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}