import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'top_match.dart'; // Ensure this is the correct path to your TopMatch page
import 'product_model.dart'; // Ensure this is the correct path to your Product model
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ProductSearch extends StatefulWidget {
  const ProductSearch({Key? key}) : super(key: key);

  @override
  _ProductSearchState createState() => _ProductSearchState();
}

class _ProductSearchState extends State<ProductSearch> {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;

  Future<void> performSearch(String input) async {
    setState(() {
      _isLoading = true;
    });

    Map<String, String> queryParams = {
      input.contains(RegExp(r'^\d+$')) ? 'barcode' : 'title': input,
      'formatted': 'y',
      'key': 'l4fe73fs298334k2yol63h4l5mzhzh',
    };

    try {
      final uri = Uri.https('api.barcodelookup.com', '/v3/products', queryParams);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<Product> products = List<Product>.from((data['products'] as List)
            .map((productData) => Product.fromJson(productData)));

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TopMatch(products: products, productName: null,),
          ),
        );
      } else {
        _showError('Product not found.');
      }
    } catch (e) {
      _showError('An error occurred.');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> scanBarcode() async {
    try {
      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        "Cancel",
        true,
        ScanMode.BARCODE,
      );

      if (barcodeScanRes == '-1') {
        _showError('Scan cancelled.');
        return;
      }

      performSearch(barcodeScanRes);
    } catch (e) {
      _showError('Failed to scan barcode: $e');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 22, 98, 160),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushNamed(context, '/landing_page'),
        ),
        title: Image.asset('assets/images/shopby.png', fit: BoxFit.cover, height: 250),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 90),
              const Text('Type a product name or barcode 😁', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
              const SizedBox(height: 30),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Search',
                  hintStyle: const TextStyle(color: Color.fromARGB(205, 33, 149, 243)),
                  prefixIcon: const Icon(Icons.search, color: Color.fromARGB(205, 33, 149, 243)),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: const BorderSide(color: Colors.white)),
                ),
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_searchController.text.isNotEmpty) {
                    performSearch(_searchController.text.trim());
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 18, 62, 97),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Text('Search by Name', style: TextStyle(color: Colors.white), textAlign: TextAlign.center), // Add some spacing 
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: scanBarcode,
                icon: const Icon(Icons.camera_alt, color: Colors.white),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 18, 62, 97),
                  foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                label:  const Text('Scan Barcode', style: TextStyle(color: Colors.white)),
              ),
              if (_isLoading) const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
