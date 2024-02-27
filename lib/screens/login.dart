import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0, // Removes the shadow under the app bar
        leading: IconButton(
          icon: const Icon(Icons.menu), // The hamburger "menu" icon
          onPressed: () {
            // Handle drawer open here
          },
        ),
        title: Image.asset(
          'assets/images/shopby.png', // Update with the correct asset path
          fit: BoxFit.cover,
          height: 250, // Adjust the size as necessary
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 0), // Provides spacing from the AppBar
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Username/Email:',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10), // Spacing between input fields
              const TextField(
                obscureText: true, // Hides the password
                decoration: InputDecoration(
                  labelText: 'Enter password:',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Insert login logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 18, 62, 97),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Text('Submit'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context,'/passwrd');//forgot password logic here
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              // ... Other widgets if needed
            ],
          ),
        ),
      ),
    );
  }
}
