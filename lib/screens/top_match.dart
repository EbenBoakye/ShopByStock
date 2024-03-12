import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'product_model.dart'; // Ensure this is correctly imported

class TopMatch extends StatelessWidget {
  final List<Product> products;

  const TopMatch({super.key, required this.products, required productName});

  Future<void> checkBarcode(String barcode, BuildContext context) async {
    final querySnapshot = await FirebaseFirestore.instance
      .collection('shop_products') // Ensure this is your intended collection
      .where('barcode', isEqualTo: barcode)
      .get();

    if (querySnapshot.docs.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Product Found'),
            content: const Text('This product is available in the shop.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Product Not Found'),
            content: const Text('This product is not available in the shop.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
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
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushNamed(context, '/product_search'),
        ),
        title: const Text('Search Results', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
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
    );
  }

  Widget _productCard(Product product, BuildContext context) {
    return GestureDetector(
      onTap: () => checkBarcode(product.barcode, context),
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
