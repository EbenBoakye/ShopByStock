import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.logout, color: Colors.white),
          onPressed: () async {
            // Sign out logic
            await FirebaseAuth.instance.signOut();
            // Navigate to the login page after signing out
            Navigator.of(context).pushReplacementNamed('/login');
          },
        ),
        title: Image.asset(
          'assets/images/shopby.png', // Make sure this path is correct
          fit: BoxFit.cover,
          height: 250, // Adjust the size as necessary
        ),
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () {
            // Implement the add product functionality
          },
          icon: const Icon(Icons.add, color: Colors.blue),
          label: const Text(
            'add a product',
            style: TextStyle(color: Colors.blue),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white, // Button color
            foregroundColor: Colors.blue, // Text color
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
        ),
      ),
    );
  }
}
