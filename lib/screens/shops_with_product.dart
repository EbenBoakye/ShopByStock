import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shopbystock/screens/shop_details_map';

class ShopsWithProductPage extends StatelessWidget {
  final String barcode;
  final String productName;

  const ShopsWithProductPage({super.key, required this.barcode, required this.productName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 22, 98, 160),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Shops with Product', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      
      body: FutureBuilder<Position>(
        future: _determinePosition(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('Could not determine location.'));
          }

          return FutureBuilder<List<ShopWithProduct>>(
            future: getShopsWithProduct(barcode, snapshot.data!),
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
                  title: Text(shop.name, style: const TextStyle(color: Colors.white)),
                  subtitle: Text('Quantity: ${shop.quantity}', style: const TextStyle(color: Colors.white)),
                  trailing: Text('Distance: ${shop.distance.toStringAsFixed(2)} miles', style: const TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ShopDetailPage (
                          shopName: shop.name,
                          stockQuantity: shop.quantity,
                          shopAddress: shop.address,
                          distance: shop.distance,
                          shopLocation: shop.location// Set the location to 0, 0 for now
                         
                        ),
                      ),
                    );
                  },
                );
              },
            );

            },
          );
        },
      ),
    );
  }

  Future<List<ShopWithProduct>> getShopsWithProduct(String barcode, Position userPosition) async {
  var shops = <ShopWithProduct>[];
  var shopsCollection = FirebaseFirestore.instance.collection('shop_products');
  
  // Query the shops that have the product by the barcode
  var querySnapshot = await shopsCollection.where('barcode', isEqualTo: barcode).get();

  for (var doc in querySnapshot.docs) {
    var shopData = doc.data();
    var userDoc = await FirebaseFirestore.instance.collection('users').doc(shopData['userId']).get();
    var userData = userDoc.data() as Map<String, dynamic>;

    // Calculate distance
    double distanceInMeters = Geolocator.distanceBetween(
      userPosition.latitude,
      userPosition.longitude,
      userData['latitude'],
      userData['longitude'],
    );

    // Convert distance to miles, if necessary
    double distanceInMiles = distanceInMeters * 0.000621371;

    LatLng shopLatLng = LatLng(userData['latitude'], userData['longitude']); // Create a LatLng object

    shops.add(ShopWithProduct(
      name: userData['shopname'],
      quantity: shopData['quantity'],
      distance: distanceInMiles,
      address: userData['address'], // Make sure this is fetched correctly from userData
      location: shopLatLng, // Pass the LatLng object
    ));
  }

  // Sort the shops by distance
  shops.sort((a, b) => a.distance.compareTo(b.distance));

  return shops;
}

  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
    
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
       
        return Future.error('Location permissions are denied');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
    } 

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

class ShopWithProduct {
  String name;
  int quantity;
  double distance;
  String address;
  LatLng location; // Add LatLng property

  ShopWithProduct({
    required this.name,
    required this.quantity,
    required this.distance,
    required this.address,
    required this.location, // Initialize it in the constructor
  });
}
