import 'package:flutter/material.dart';

class Product {
  final String name;
  final String description;

  Product(this.name, this.description);
}

class TopMatch extends StatelessWidget {
  final List<Product> products;

  const TopMatch({
    super.key,
    required this.products, required productName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Image.asset(
          'assets/images/shopby.png',
          fit: BoxFit.cover,
          height: 250, // Adjusted the height for consistency
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Top match',
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Center(
                child: SizedBox(
                  width: 340,
                  height: 150,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(products.first.name, style: const TextStyle(fontSize: 20)),
                          const SizedBox(height: 8),
                          Text(products.first.description),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 90),
              const Text(
                'Similar products',
                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length - 1, // Subtract 1 since the top match is not included in this list
                itemBuilder: (context, index) {
                  // Adjust index to skip the first product
                  final product = products[index + 1];
                  return Card(
                    child: ListTile(
                      title: Text(product.name),
                      subtitle: Text(product.description),
                      onTap: () {
                        // Implement navigation to product detail page if needed
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}