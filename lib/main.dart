import 'package:flutter/material.dart';
import 'package:shopby/screens/passwrd.dart';
import 'package:shopby/screens/regpage.dart';
import 'package:shopby/screens/landing_page.dart';
import 'package:shopby/screens/login.dart';
import 'package:shopby/screens/product_search.dart';
import 'package:shopby/screens/top_match.dart';

void main() {
  
  runApp(const Homepage());
}


class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       //home: const ShopBystock(),
       //home: const RegistrationPage(),
      //home: const TopMatch(),
      //home: const ProductSearch(),
      home: const LoginPage(),
      //home: const ForgotPasswordPage(),

     routes: {
      
      '/product_search': (context) => const ProductSearch(),
      '/top_match': (context) => const TopMatch(),
      '/regpage': (context) => const RegistrationPage(),
      '/login': (context) => const LoginPage(),
      '/passwrd': (context) => const ForgotPasswordPage(),
      
     },
    );
  }
}

