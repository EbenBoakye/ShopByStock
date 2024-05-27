import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopbystock/screens/Shops_with_product.dart';
import 'package:shopbystock/screens/background.dart';
import 'product_model.dart';

// The TopMatch widget displays the search results for a product.
class TopMatch extends StatelessWidget {
  final List<Product> products;

  const TopMatch({super.key, required this.products, required productName,});

  Future<void> checkBarcode(String barcode, String productName ,BuildContext context) async {
  final querySnapshot = await FirebaseFirestore.instance
    .collection('shop_products') // Ensure this is your intended collection
    .where('barcode', isEqualTo: barcode)
    .get();

  if (querySnapshot.docs.isNotEmpty) {
    // Navigate to the new page that will display the shops with product in stock
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ShopsWithProductPage(
          barcode: barcode,
          productName:productName // You need to pass the product name
        ),
      ),
    );
  } else {
    // No matching barcode found, show an error dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Product Not Found', style: TextStyle(color: Color.fromARGB(255, 8, 114, 220))),
          content: const Text('This product is not available in any shop.', style: TextStyle(color: Color.fromARGB(255, 8, 114, 220))),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK', style: TextStyle(color: Color.fromARGB(255, 8, 114, 220))),
            ),
          ],
        );
      },
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 22, 98, 160),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 8, 114, 220),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushNamed(context, '/product_search'),
        ),
        title: const Text('Search Results', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        elevation: 0,
      ),
       body: Container(
        decoration: backgroundImageBoxDecoration(),
        child: 
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: products.isEmpty
              ? const Center(child: Text('No products found', style: TextStyle(color: Colors.white)))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: products.map((product) => _productCard(product, context)).toList(),
                ),
        ),
      ),
    ));
  }
  Widget _productCard(Product product, BuildContext context) {
    return GestureDetector(
      onTap: () => checkBarcode(product.barcode, product.title, context),
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (product.imageUrl.isNotEmpty)
              Image.network(product.imageUrl, fit: BoxFit.cover),
            ListTile(
              title: Text(product.title),
              subtitle: Text('Barcode: ${product.barcode}\nPrice: ${product.price}\nDescription: ${product.description}'),
              trailing: const Icon(Icons.chevron_right),
            ),
          ],
        ),
      ),
    );
  }
}
