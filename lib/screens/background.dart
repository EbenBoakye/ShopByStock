
// Create a common BoxDecoration
import 'package:flutter/material.dart';

BoxDecoration backgroundImageBoxDecoration() {
  return const BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/images/back.PNG'), // Replace with your image path
      fit: BoxFit.cover,
    ),
  );
}
