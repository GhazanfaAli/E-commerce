import 'package:e_commerce/views/auth_screen/welcome_screen.dart';
import 'package:e_commerce/views/home/main_page_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireBaseServices {
  Future<void> isLogin(BuildContext context) async {
    try {
      final auth = FirebaseAuth.instance;
      final user = auth.currentUser;

      // Navigate based on the authentication state
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainPageScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const WelcomeScreen()),
        );
      }
    } catch (e) {
      // Handle any errors that might occur during the login check
      print("Error in isLogin: $e");
      // You might want to navigate to an error screen or show an error message
    }
  }
}
