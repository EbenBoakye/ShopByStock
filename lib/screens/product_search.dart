import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'top_match.dart'; // Make sure to import the TopMatch page correctly
import 'product_model.dart'; // Make sure to import the Product class correctly

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

    // Define query parameters based on input type
    Map<String, String> queryParams = {
      input.contains(RegExp(r'^\d+$')) ? 'barcode' : 'title': input,
      'formatted': 'y',
      'key': 'fi4jjhtjuesh99e8bynyct2gkxyffd', // Use your actual API key
    };

    try {
      final uri = Uri.https('api.barcodelookup.com', '/v3/products', queryParams);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<Product> products = List<Product>.from((data['products'] as List).map((productData) => Product.fromJson(productData)));

        // Navigate to TopMatch with the list of Product objects
        Navigator.push(context, MaterialPageRoute(builder: (context) => TopMatch(products: products, productName: null,)));
      } else {
        _showError('Product not found.'); // Use the _showError method for user feedback
      }
    } catch (e) {
      _showError('An error occurred.'); // Use the _showError method for error feedback
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushNamed(context, '/main'), // Handle back navigation
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
              const Text('Type a product name or barcode', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24)),
              const SizedBox(height: 30),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Search',
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: Colors.white)),
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
                child: const Text('Submit'),
              ),
              if (_isLoading) const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
