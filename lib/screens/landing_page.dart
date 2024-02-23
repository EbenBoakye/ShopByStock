import 'package:flutter/material.dart';
import 'package:shopby/screens/product_search.dart';

class ShopBystock extends StatefulWidget {
  const ShopBystock({super.key});

  @override
  State<ShopBystock> createState() => _ShopBystockState();
}

class _ShopBystockState extends State<ShopBystock> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: ListView(
            children: [
              Image.asset('assets/images/shopbystockpage.jpeg'),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the ProductSearch page
                    Navigator.pushReplacementNamed(context, '/product_search');
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  child: const Text(
                    'Product Search',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/regpage');// Handle Admin sign up navigation
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  child: const Text(
                    'Admin sign up',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextButton(
                onPressed: () {
                  // Handle 'Already have an account' navigation
                },
                child: const Text(
                  'Already have an account',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle Admin Log-in navigation
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  child: const Text(
                    'Admin Log-in',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      );
  }
}
