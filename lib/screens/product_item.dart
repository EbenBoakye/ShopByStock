import 'package:flutter/material.dart';
import 'edit_product.dart'; // Make sure to import your EditProductPage

class ProductItem extends StatelessWidget {
  final String documentID; // Add a documentID property
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

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(name),
        subtitle: Text('Barcode: $barcode\nQuantity: $quantity'),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            // Navigate to EditProductPage with product details
           Navigator.push(
                context,
                 MaterialPageRoute(
                  builder: (context) => EditProductPage(
                  documentID: documentID, // This should be the actual document ID from Firestore
                  name: name,
                  barcode: barcode,
                  quantity: quantity,
                ),
              ),
            );

          },
        ),
      ),
    );
  }
}
