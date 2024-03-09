import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shopbystock/screens/login.dart';

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
                    Navigator.pushNamed(context, '/product_search');
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue), 
                    alignment: Alignment.center,
                    padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
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
              const SizedBox(height: 170),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/regpage');// Handle Admin sign up navigation
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  child: const Text(
                    'Shop sign-up',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
             const SizedBox(height: 40),
            Align(
              alignment: Alignment.center, // Aligns the RichText widget in the center
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 18, color: Color.fromARGB(255, 6, 93, 164), fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    const TextSpan(text: 'Already have an account? '),
                    TextSpan(
                      text: 'Login here.',
                      style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            ],
          ),
        ),
      );
  }
}
