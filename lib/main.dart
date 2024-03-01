import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shopbystock/firebase_options.dart';
import 'package:shopbystock/screens/home.dart';
import 'package:shopbystock/screens/passwrd.dart';
import 'package:shopbystock/screens/regpage.dart';
import 'package:shopbystock/screens/landing_page.dart';
import 'package:shopbystock/screens/login.dart';
import 'package:shopbystock/screens/product_search.dart';
import 'package:shopbystock/screens/top_match.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const Homepage());
}


class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: const ShopBystock(),
       //home: const RegistrationPage(),
      home: const TopMatch(),
      //home: const ProductSearch(),
      //home: const LoginPage(),
      //home: const ForgotPasswordPage(),
      //home: const AddProduct(),
     routes: {
      
      '/product_search': (context) => const ProductSearch(),
      '/top_match': (context) => const TopMatch(),
      '/regpage': (context) => const RegistrationPage(),
      '/login': (context) => const LoginPage(),
      '/passwrd': (context) => ForgotPasswordPage(),
      '/main': (context) => const ShopBystock(),
      '/home': (context) => const AddProduct(),
     },
    );
  }
}

