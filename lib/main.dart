import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shopbystock/firebase_options.dart';
import 'package:shopbystock/screens/home.dart';
import 'package:shopbystock/screens/passwrd.dart';
import 'package:shopbystock/screens/regpage.dart';
import 'package:shopbystock/screens/landing_page.dart';
import 'package:shopbystock/screens/login.dart';
import 'package:shopbystock/screens/product_search.dart';
import 'package:shopbystock/screens/shop_admin_product.dart';
import 'package:shopbystock/screens/shop_details_map';
import 'package:shopbystock/screens/shops_with_product.dart';
import 'package:shopbystock/screens/top_match.dart';
import 'package:shopbystock/screens/product_details.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

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
     home: const ShopBystock(),
      //home: const RegistrationPage(),
     //home: const TopMatch(products: [], productName: null,),
      //home: const ProductSearch(),
      //home: const LoginPage(),
      //home: ForgotPasswordPage(),
      //home: const AddProduct(),
      //home: const AddProductDetails(scannedBarcode: '',),
      //initialRoute: '/main',
     routes: {
      
      '/product_search': (context) => const ProductSearch(),
      '/top_match': (context) => const TopMatch(products: [], productName: null,),
      '/regpage': (context) => const RegistrationPage(),
      '/login': (context) => const LoginPage(),
      '/passwrd': (context) => ForgotPasswordPage(),
      '/main': (context) => const ShopBystock(),
      '/home': (context) => const AddProduct(),
      '/product_details': (context) => const AddProductDetails(scannedBarcode: '',),
      '/landing_page': (context) => const ShopBystock(),
      '/shop_admin_products': (context) => const ShopAdminProductsPage(),
      '/shop_with_product': (context) => const ShopsWithProductPage(barcode: '', productName: ''),
      '/shop_details_map': (context) => const ShopDetailPage(shopName: '', distance: 0, shopAddress: '', shopLocation: LatLng(0, 0), proDocumentId: ''),
      
      
     },
    );
  }
}

