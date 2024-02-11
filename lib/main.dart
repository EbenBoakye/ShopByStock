import 'package:flutter/material.dart';
import 'package:shopby/screens/landing_page.dart';

import 'package:shopby/screens/product_search.dart';

void main() {
  
  // runApp(const ProductSearch());
  runApp(const Homepage());
}


class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const ShopBystock(), 

     routes: {
      
      '/product_search': (context) => const ProductSearch(),
     },
    );
  }
}

