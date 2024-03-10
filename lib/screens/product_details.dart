import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddProductDetails extends StatefulWidget {
  final String scannedBarcode;

  const AddProductDetails({super.key, required this.scannedBarcode});

  @override
  _AddProductDetailsState createState() => _AddProductDetailsState();
}

class _AddProductDetailsState extends State<AddProductDetails> {
  final _productNameController = TextEditingController();
  final _productQuantityController = TextEditingController();

  Future<void> _addProduct() async {
    final productName = _productNameController.text;
    final productQuantity = int.tryParse(_productQuantityController.text) ?? 0;

    if (productName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a product name')));
      return;
    }

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('shop_products').add({
          'userId': user.uid,
          'barcode': widget.scannedBarcode,
          'name': productName,
          'quantity': productQuantity,
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
        title: const Text('Product Details', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: const Color.fromARGB(205, 33, 149, 243),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center the content vertically
              children: [
                TextField(
                  controller: _productNameController,
                  decoration: InputDecoration(
                    labelText: 'Product Name',
                    labelStyle: TextStyle(color: Colors.blue.shade900),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0), // Make edges rounder
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _productQuantityController,
                  decoration: InputDecoration(
                    labelText: 'Quantity',
                    labelStyle: TextStyle(color: Colors.blue.shade900),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0), // Make edges rounder
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _addProduct,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 18, 62, 97), // Button background color
                    foregroundColor: Colors.white, // Button text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  ),
                  child: const Text('Add Product'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
