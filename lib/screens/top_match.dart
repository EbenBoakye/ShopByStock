import 'package:flutter/material.dart';


class TopMatch extends StatelessWidget {
   const TopMatch({Key? key}) : super(key: key);
  
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
            // openDrawer();
          },
        ),
        title: Image.asset('/Users/student/dev/projects/shopby/assets/images/shopby.png', fit: BoxFit.cover, width: 250, height: 250),
        // If you want to remove the shadow, set elevation to 0
        elevation: 0,
      ),
     
     );
  }
}