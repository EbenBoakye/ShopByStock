import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shopbystock/screens/top_match.dart';

// Define your Product model (if you plan to pass complex data)
class Product {
  final String name;
  final String description;

  Product({required this.name, required this.description});
}

class ProductSearch extends StatefulWidget {
  const ProductSearch({super.key});

  @override
  _ProductSearchState createState() => _ProductSearchState();
}

class _ProductSearchState extends State<ProductSearch> {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  String? _searchResult;

  Future<void> performSearch(String query) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse('https://api.barcodelookup.com/v3/products?barcode=$query&formatted=y&key=YOUR_API_KEY'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Assuming the API returns a list of items
        // Here, for simplicity, we're just grabbing the product name
        final productName = data['products'][0]['product_name'];

        // Navigate to the TopMatch page with the search result
        Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => TopMatch(productName: productName, products: const [],), // Assuming TopMatch accepts a productName parameter
          ),
        );
      } else {
        setState(() {
          _searchResult = 'Product not found.';
        });
      }
    } catch (e) {
      setState(() {
        _searchResult = 'An error occurred.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, '/main'); // Just pop the current screen
          },
        ),
        title: Image.asset(
          'assets/images/shopby.png',
          fit: BoxFit.cover,
          height: 250, // Adjust the size as necessary
        ),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 90),
              const Text(
                'Type a product name or barcode',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Search',
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Text('Submit'),
              ),
              if (_isLoading)
                const CircularProgressIndicator(),
              if (_searchResult != null) Text(_searchResult!, style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
