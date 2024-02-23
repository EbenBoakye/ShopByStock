import 'package:flutter/material.dart';

// class AdminSign extends StatelessWidget {
//   const AdminSign({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primaryColor: Colors.blue,
//       ),
//       home: const RegistrationPage(),
//     );
//   }
// }

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar( 
        backgroundColor: Colors.blue,
        elevation: 0, // removes the shadow under the app bar
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Handle drawer open here
          },
        ),
        title: Image.asset(
          'assets/images/shopby.png', // Make sure the path is correct and the image is added to your pubspec.yaml
          fit: BoxFit.cover,
          height: 250, // Set an appropriate height for your AppBar title image
        ),
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // You can use a SizedBox for spacing or just add padding/margin to the first TextField
            const SizedBox(height: 10), // Adjust the space according to your design
           const TextField(
              decoration: InputDecoration(
                labelText: 'Post Code:',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10), // Spacing between input fields
         const   TextField(
              decoration: InputDecoration(
                labelText: 'Email:',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
          const  TextField(
              obscureText: true, // Use this to obscure text for password fields
              decoration: InputDecoration(
                labelText: 'Enter password:',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
         const   TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm password:',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20), // Spacing before the submit button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
               backgroundColor: const Color.fromARGB(255, 18, 62, 97), // Button background color
    foregroundColor: Colors.white, // Button text color
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0), // Rounded edges
    ),
     padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Button padding
  ),
  onPressed: () { 
    
   },
  child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
