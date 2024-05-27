import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopbystock/screens/background.dart';
import 'dart:convert';
import 'top_match.dart'; // Ensure this is the correct path to your TopMatch page
import 'product_model.dart'; // Ensure this is the correct path to your Product model
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProductSearch extends StatefulWidget {
  const ProductSearch({super.key});

  @override
  _ProductSearchState createState() => _ProductSearchState();
}

class _ProductSearchState extends State<ProductSearch> {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  
  @override
void initState() {
  super.initState();
  _loadLastSearch();
}

Future<void> _loadLastSearch() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? lastSearch = prefs.getString('last_search');
  if (lastSearch != null) {
    _searchController.text = lastSearch;
    // Optionally perform the search automatically
    // performSearch(lastSearch);
  }
}

  Future<void> performSearch(String input) async {
    setState(() {
      _isLoading = true;
    });

    Map<String, String> queryParams = {
      input.contains(RegExp(r'^\d+$')) ? 'barcode' : 'title': input,
      'formatted': 'y',
      'key': 'l4c5b8il49fhu4gpsf4qevqwle91dp',
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_search', input);

    try {
      final uri = Uri.https('api.barcodelookup.com','/v3/products', queryParams);
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

//The UI of the product search page is defined in the build method of the _ProductSearchState class.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 22, 98, 160),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 8, 114, 220),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushNamed(context, '/landing_page'),
        ),
        title: Image.asset('assets/images/shopby.png', fit: BoxFit.cover, height: 250),
        elevation: 0,
      ),
      //The body of the Scaffold widget is a Container widget with a background image and a Center widget as its child.
      //The Center widget contains a SingleChildScrollView widget with a Column widget as its child.
      //The Column widget displays a text field for the user to enter a product name or barcode.
      body: Container(
        decoration: backgroundImageBoxDecoration(),
        child:
       Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 90),
              const Text('Type a product name or barcode', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
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
    ));
  }
}
