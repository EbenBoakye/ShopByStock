import 'package:flutter/material.dart';

class ProductSearch extends StatelessWidget {
  const ProductSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        // You can set the background color to match your Scaffold's background or use a different color
        backgroundColor: Colors.blue,
        // Add leading IconButton that opens a drawer
        leading: IconButton(
          icon: const Icon(Icons.menu), // The hamburger "menu" icon
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        title: Image.asset('/Users/student/dev/projects/shopby/assets/images/shopby.png', fit: BoxFit.cover, width: 250, height: 250),
        // If you want to remove the shadow, set elevation to 0
        elevation: 0,
      ),
      // Define the drawer
      drawer: Drawer(
        // Add a ListView in the drawer
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Add a drawer header
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            // Add drawer menu items
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Shop'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            // Add more ListTile widgets for more menu items...
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 240),
            const Text('Type a product name or barcode', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24,)),
            const SizedBox(height: 20),
           TextField(
  decoration: InputDecoration(
    filled: true,
    fillColor: Colors.white, // Set the fill color to white
    hintText: 'Search',
    hintStyle: TextStyle(color: Colors.grey),
    prefixIcon: Icon(Icons.search, color: Colors.grey),
    // Define the border, focusedBorder, and enabledBorder to customize the appearance
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0), // Rounded corners with a radius of 10.0
      borderSide: BorderSide.none, // No border
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0), // Keep consistent radius with the border
      borderSide: BorderSide(color: Colors.blue), // Define a border side when the TextField is focused
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0), // Keep consistent radius with the border
      borderSide: BorderSide.none, // Usually no border when the TextField is enabled and not focused
    ),
  ),
  style: TextStyle(color: Colors.black), // Text color
),

            TextButton(
              onPressed: () {
                Navigator.maybePop(context);
              },
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
