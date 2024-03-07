import 'package:flutter/material.dart';
import 'product_model.dart'; // Import your Product model correctly

class TopMatch extends StatelessWidget {
  final List<Product> products;

  const TopMatch({super.key, required this.products, required productName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushNamed(context, '/product_search'), // Handle back navigation
        ),
        title: const Text('Search Results',style: TextStyle(fontWeight: FontWeight.bold,) ),// Updated for clarity
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: products.isEmpty
              ? const Center(child: Text('No products found', style: TextStyle(color: Colors.white)))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: products.map((product) => _productCard(product)).toList(),
                ),
        ),
      ),
    );
  }

  Widget _productCard(Product product) {
    return Card(
      child: Column(
        children: [
          if (product.imageUrl.isNotEmpty)
            Image.network(product.imageUrl, fit: BoxFit.cover),
          ListTile(
            title: Text(product.title),
            subtitle: Text('Barcode Formats: ${product.barcodeFormats}\nPrice: ${product.price}\n${product.description}'),
          ),
        ],
      ),
    );
  }
}
