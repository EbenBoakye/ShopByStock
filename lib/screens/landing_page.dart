import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shopbystock/screens/login.dart';

class ShopBystock extends StatefulWidget {
  const ShopBystock({super.key});

  @override
  State<ShopBystock> createState() => _ShopBystockState();
}

class _ShopBystockState extends State<ShopBystock>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1.5, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
//The UI of the landing page is defined in the build method of the _ShopBystockState class. 
//The build method returns a Scaffold widget with a ListView as its body. 
//The ListView contains a SlideTransition widget with an Image widget as its child. 
//The Image widget displays an image of the ShopByStock landing page. 
//Below the image, there are two ElevatedButton widgets that navigate to the product search page and the registration page when pressed. 
//The ElevatedButton widgets are wrapped in a SlideTransition widget to animate their appearance on the screen. 
//The last part of the ListView contains a RichText widget with a link to the login page. 
//The link is styled to look like a hyperlink and has a TapGestureRecognizer that navigates to the login page when clicked.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: ListView(
          children: [
            SlideTransition(
              position: _slideAnimation,
              child: Image.asset('assets/images/shopbystockpage.jpeg'),
            ),
            SlideTransition(
              position: _slideAnimation,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/product_search');
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                  ),
                  child: const Text(
                    'Product Search',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 170),
            SlideTransition(
              position: _slideAnimation,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/regpage');
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  child: const Text(
                    'Shop sign-up',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Align(
              alignment: Alignment.center,
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 6, 93, 164),
                      fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    const TextSpan(text: 'Already have an account? '),
                    TextSpan(
                      text: 'Login here.',
                      style: const TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}