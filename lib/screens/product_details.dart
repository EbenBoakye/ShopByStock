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
  final _formKey = GlobalKey<FormState>();
  String productName = '';

  @override
  Widget build(BuildContext context) {
    Colors.blue;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product Details', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Product Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the product name';
                  }
                  return null;
                },
                onSaved: (value) => productName = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _submitProduct(context),
                child: const Text('Add Product', style: TextStyle(color: Colors.white),)
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitProduct(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await FirebaseFirestore.instance.collection('products').add({
            'userId': user.uid, // Store the user ID for reference
            'barcode': widget.scannedBarcode, // The scanned barcode
            'name': productName, // Product name entered by the user
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Product added successfully')),
          );

          Navigator.of(context).pop(); // Optionally navigate back to the previous screen
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add product: $e')),
        );
      }
    }
  }
}
