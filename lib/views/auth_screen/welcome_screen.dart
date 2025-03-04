import 'dart:ui';
import 'package:e_commerce/views/auth_screen/login_screen.dart';
import 'package:e_commerce/views/auth_screen/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  double _scaleLogInButton = 1.0;
  double _scaleSignUpButton = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _backgroundGradients(context),
          _foregroundWidgets(context),
        ],
      ),
    );
  }

  Widget _backgroundGradients(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(29, 39, 79, 1), // Dark navy blue
            Color.fromRGBO(44, 57, 110, 1), // Deeper blue
          ],
        ),
      ),
    );
  }

  Widget _foregroundWidgets(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _avatarImage(context),
            _textSection(context),
            _actionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _avatarImage(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.75,
        height: MediaQuery.of(context).size.height * 0.35,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: Container(
                  color: Colors.black.withOpacity(0.1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Lottie.network('https://lottie.host/06b031ec-639c-4026-a85d-e5ecd7c5257e/Wf0NbOCdtk.json',fit: BoxFit.cover),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textSection(BuildContext context) {
    return const Column(
      children: [
        Text(
          'Welcome to E-Shop!',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(255, 255, 255, 1), // White color for title
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 5),
        Text(
          'Your one-stop shop for all your needs\nShop the latest trends and exclusive deals!',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white70, // Lighter color for subtitle
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _actionButtons(BuildContext context) {
    return Column(
      children: [
        _buildAnimatedButton(
          context,
          'Log In',
          const Color.fromRGBO(255, 87, 34, 1), // Deep Orange
          const Color.fromRGBO(255, 138, 101, 1), // Light Orange
          () {
            _navigateToScreen(context, const LoginScreen());
          },
          (scale) {
            setState(() {
              _scaleLogInButton = scale;
            });
          },
        ),
        const SizedBox(height: 10),
        _buildAnimatedButton(
          context,
          'Sign Up',
          const Color.fromRGBO(33, 150, 243, 1), // Deep Blue
          const Color.fromRGBO(144, 202, 249, 1), // Light Blue
          () {
            _navigateToScreen(context, SignUpScreen());
          },
          (scale) {
            setState(() {
              _scaleSignUpButton = scale;
            });
          },
        ),
      ],
    );
  }

  Widget _buildAnimatedButton(
      BuildContext context, String text, Color startColor, Color endColor, VoidCallback onPressed, Function(double) onScaleChanged) {
    return GestureDetector(
      onTapDown: (_) => onScaleChanged(0.9),
      onTapUp: (_) {
        onScaleChanged(1.0);
        onPressed();
      },
      onTapCancel: () => onScaleChanged(1.0),
      child: Transform.scale(
        scale: text == 'Log In' ? _scaleLogInButton : _scaleSignUpButton,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: MediaQuery.of(context).size.width * 0.8,
          height: 60, // Fixed height for better aesthetics
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [startColor, endColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 21,fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}
