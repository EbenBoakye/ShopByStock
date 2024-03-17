import 'package:flutter/material.dart';

class ShopsWithProductPage extends StatelessWidget {
  final String barcode;
  final String productName;

  const ShopsWithProductPage({super.key, required this.barcode, required this.productName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shops with $productName'),
      ),
      body: FutureBuilder<List<ShopWithProduct>>(
        future: getShopsWithProduct(barcode),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No shops found with this product.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              ShopWithProduct shop = snapshot.data![index];
              return ListTile(
                title: Text(shop.name),
                subtitle: Text('Quantity: ${shop.quantity}'),
                trailing: Text('Distance: ${shop.distance}km'), // Assuming distance is in kilometers
              );
            },
          );
        },
      ),
    );
  }

  Future<List<ShopWithProduct>> getShopsWithProduct(String barcode) async {
    // Here you would write your logic to query the shops, calculate distances, etc.
    // This is just a placeholder function
    return [];
  }
}

class ShopWithProduct {
  String name;
  int quantity;
  double distance;

  ShopWithProduct({
    required this.name,
    required this.quantity,
    required this.distance,
  });
}
