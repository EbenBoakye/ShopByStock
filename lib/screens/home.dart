import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddProductDetails extends StatefulWidget {
  final String scannedBarcode;

  const AddProductDetails({super.key, required this.scannedBarcode});

  @override
  State<AddProductDetails> createState() => _AddProductDetailsState();
}

class _AddProductDetailsState extends State<AddProductDetails> {
  final _productNameController = TextEditingController();
  final _productQuantityController = TextEditingController();

  Future<void> _addProduct() async {
    final productName = _productNameController.text;
    final productQuantity = int.tryParse(_productQuantityController.text) ?? 0; // Default to 0 if parsing fails

    if (productName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a product name')));
      return;
    }

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('products').add({
          'userId': user.uid, // Store the user ID for reference
          'barcode': widget.scannedBarcode, // The scanned barcode
          'name': productName, // Product name entered by the user
          'quantity': productQuantity, // Quantity of the product
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Product added successfully with quantity: $productQuantity')));
        Navigator.of(context).pop();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error adding product: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details', ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _productNameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: _productQuantityController,
              decoration: const InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number, // Ensures numeric input
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addProduct,
              child: const Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
