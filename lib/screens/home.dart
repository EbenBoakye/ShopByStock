import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
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
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.logout, color: Colors.white),
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).pushNamed('/login');
          },
        ),
        title: const Text('Add Product', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () => scanBarcode(context),
          icon: const Icon(Icons.camera_alt, color: Colors.white),
          label: const Text('Scan Barcode', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 18, 62, 97), // Background color
            foregroundColor: Colors.white, // Icon and Text color
          ),
        ),
      ),
    );
  }
}
