import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProductPage extends StatefulWidget {
  final String documentID;
  final String name;
  final String barcode;
  final int quantity;

  const EditProductPage({
    super.key,
    required this.name,
    required this.barcode,
    required this.quantity, 
    required this.documentID,
  });
  
  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  late TextEditingController _nameController;
  late TextEditingController _barcodeController;
  late TextEditingController _quantityController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _barcodeController = TextEditingController(text: widget.barcode);
    _quantityController = TextEditingController(text: widget.quantity.toString());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _barcodeController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  Future<void> _updateProduct() async {
    // Ensuring the quantity is a positive number
    int quantity = int.tryParse(_quantityController.text) ?? 0;
    if (quantity <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Quantity must be a positive number.')));
      return;
    }

    try {
      // Use the documentID instead of the barcode to reference the document
      await FirebaseFirestore.instance.collection('shop_products').doc(widget.documentID).update({
        'name': _nameController.text,
        'quantity': int.tryParse(_quantityController.text) ?? 0,
        
      });

      // Showing a confirmation dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Update Successful'),
            content: const Text('The product details have been successfully updated.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Dismiss dialog
                  Navigator.of(context).pop(); // Go back to the previous page
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error updating product: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Product Name', labelStyle: TextStyle(color: Colors.blue)),
            ),
            TextField(
              controller: _barcodeController,
              decoration: const InputDecoration(labelText: 'Barcode', labelStyle: TextStyle(color: Colors.blue)),
              enabled: false, // Make barcode field read-only
            ),
            TextField(
              controller: _quantityController,
              decoration: const InputDecoration(labelText: 'Quantity', labelStyle: TextStyle(color: Colors.blue)),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateProduct,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 18, 62, 97),
                foregroundColor: Colors.white,
              ),
              child: const Text('Update Product'),
            ),
          ],
        ),
      ),
    );
  }
}
