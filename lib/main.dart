import 'package:flutter/material.dart';
import 'package:shopby/screens/landing_page.dart';

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
       home: const ShopBystock(), 
      //home: const TopMatch(),

     routes: {
      
      '/product_search': (context) => const ProductSearch(),
      
     },
    );
  }
}

