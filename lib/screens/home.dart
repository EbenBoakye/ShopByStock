import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:shopbystock/screens/background.dart';
import 'shop_admin_product.dart'; // Make sure this import points to your ShopAdminProductsPage widget file
import 'product_details.dart'; // Ensure this import points to your AddProductDetails widget file

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  Future<void> scanBarcode(BuildContext context) async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      "#ff6666", "Cancel", true, ScanMode.BARCODE);

    if (barcodeScanRes != '-1') {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddProductDetails(scannedBarcode: barcodeScanRes),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 22, 98, 160),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.logout, color: Colors.white),
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).pushReplacementNamed('/login');
          },
        ),
        title: const Text('Add Product', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      body: Container(
        decoration: backgroundImageBoxDecoration(),
        child:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () => scanBarcode(context),
              icon: const Icon(Icons.camera_alt, color: Colors.white),
              label: const Text('Scan Barcode', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 18, 62, 97), // Background color
                foregroundColor: Colors.white, // Icon and Text color
              ),
            ),
            const SizedBox(height: 20), // Add some spacing
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ShopAdminProductsPage()));
              },
              icon: const Icon(Icons.list, color: Colors.white),
              label: const Text('View My Products', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 18, 62, 97), // Background color
                foregroundColor: Colors.white, // Icon and Text color
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
