import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'edit_product.dart';

class ProductItem extends StatelessWidget {
  final String documentID;
  final String name;
  final String barcode;
  final int quantity;

  const ProductItem({
    super.key,
    required this.documentID,
    required this.name,
    required this.barcode,
    required this.quantity,
  });

  Future<void> _confirmDelete(BuildContext context) async {
    final bool? confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Delete Product', style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
          content: Text('Are you sure you want to delete "$name" from your product list?', style: const TextStyle(color: Colors.blue)),
          actions: [
            TextButton(
              child: const Text('Cancel', style: TextStyle(color: Colors.blue),),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: const Text('Delete', style: TextStyle(color: Colors.blue),),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );

    // If the user confirmed, then proceed to delete the product
    if (confirmDelete == true) {
      _deleteProduct(context);
    }
  }

  Future<void> _deleteProduct(BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('shop_products').doc(documentID).delete();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Product deleted successfully')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to delete product: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(name),
        subtitle: Text('Barcode: $barcode\nQuantity: $quantity'),
        trailing: Wrap(
          spacing: 12, // space between two icons
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                // Navigate to EditProductPage with product details
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProductPage(
                      documentID: documentID,
                      name: name,
                      barcode: barcode,
                      quantity: quantity,
                    ),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _confirmDelete(context),
            ),
          ],
        ),
      ),
    );
  }
}
