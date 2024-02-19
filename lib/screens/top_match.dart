import 'package:flutter/material.dart';

class TopMatch extends StatelessWidget {
  const TopMatch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        title: Image.asset(
          'assets/images/shopby.png', // Make sure the path is correct and the image is added to your pubspec.yaml
          fit: BoxFit.cover,
          height: 250, // Set an appropriate height for your AppBar title image
        ),
        elevation: 0,
      ),
      drawer: Drawer(
        // Populate your Drawer here
        child: ListView(
          // Add Drawer items
        ),
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
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const Center(
                child: SizedBox(
                  width: 340, // Set the width of the card
                  height: 150, // Set the height of the card
                  child: Card(
                    // Customize your card appearance
                    child: Padding(
                      padding:  EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Your card content goes here
                          Text('Product Name', style: TextStyle(fontSize: 20)),
                          SizedBox(height: 8),
                          Text('Product Description'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 90),
              const Text(
                'Similar products',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListView.builder(
                // This builds a list of similar products cards
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(), // to disable ListView's scrolling
                itemCount: 4, // The count of similar products
                itemBuilder: (context, index) {
                  return const Card(
                    child: ListTile(
                      title:  Text('Name'),
                      subtitle: Text('Product description'),
                      // Add your content
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
