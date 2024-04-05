import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopbystock/screens/background.dart';
import 'product_item.dart'; // Import your ProductItem widget

class ShopAdminProductsPage extends StatefulWidget {
  const ShopAdminProductsPage({super.key});

  @override
  _ShopAdminProductsPageState createState() => _ShopAdminProductsPageState();
}

class _ShopAdminProductsPageState extends State<ShopAdminProductsPage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Products', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 8, 114, 220),
      ),
      backgroundColor: const Color.fromARGB(255, 22, 98, 160),
       body: Container(
        decoration: backgroundImageBoxDecoration(),
        child:
       StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('shop_products')
            .where('userId', isEqualTo: user?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final productDocs = snapshot.data?.docs ?? [];
          return ListView.builder(
            itemCount: productDocs.length,
            itemBuilder: (context, index) {
              var product = productDocs[index];
              return ProductItem(
                documentID: product.id, // Firestore document ID
                name: product['name'],
                barcode: product['barcode'],
                quantity: product['quantity'],
              );
            },
          );
        },
      ),
    ));
  }
}
