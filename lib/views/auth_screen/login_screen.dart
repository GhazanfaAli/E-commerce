import 'dart:ui';
import 'package:e_commerce/views/auth_screen/google_sign.dart';
import 'package:e_commerce/views/auth_screen/signup_screen.dart';
import 'package:e_commerce/views/auth_screen/widgets/email_input_widget.dart';
import 'package:e_commerce/views/auth_screen/widgets/login_button.dart';
import 'package:e_commerce/views/home/main_page_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/blocs/auth_bloc/bloc/auth_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'widgets/password_input_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  double _buttonScale = 1.0; // Define the scale for the animated button

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Scaffold(
        body: Stack(
          children: [
            _backgroundGradients(context),
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthAuthenticated) {
                  // Navigate to MainPageScreen on successful login
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainPageScreen(),
                    ),
                  );
                } else if (state is AuthError) {
                  // Show error if login fails
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              child: _foregroundWidgets(context),
            ),
          ],
        ),
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
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.6,
                width: MediaQuery.of(context).size.height * 0.6,
                child: Lottie.network('https://lottie.host/2b86d691-624a-4961-8c51-048ec0c90603/9tT385zTnP.json'),
              ),
              const SizedBox(height: 20),
              _loginForm(),
              const SizedBox(height: 20),
              _divider(),
              const SizedBox(height: 20),
              _signUpOption(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          EmailInputWidget(controller: _emailController),
          const SizedBox(height: 20),
          PasswordInputWidget(controller: _passwordController),
          const SizedBox(height: 20),
          SubmitButton(
            formKey: _formKey,
            emailController: _emailController,
            passwordController: _passwordController,
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return const Column(
      children: [
        Text(
          '--------------------  Or -------------------',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _signUpOption(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTapDown: (_) => _animateButtonDown(),
          onTapUp: (_) => _animateButtonUp(context),
          child: AnimatedScale(
            scale: _buttonScale,  // Apply the scaling factor
            duration: const Duration(milliseconds: 200),
            child: SocialLoginButton(
              text: 'Sign with Google',
              borderRadius: 10,
              fontSize: 17,
              buttonType: SocialLoginButtonType.google,
              onPressed: null, // Handled by GestureDetector
            ),
          ),
        ),
      ],
    );
  }

  // Button animation down (on press)
  void _animateButtonDown() {
    setState(() {
      _buttonScale = 0.9;  // Shrink the button
    });
  }

  // Button animation up (on release)
  void _animateButtonUp(BuildContext context) async {
    setState(() {
      _buttonScale = 1.0;  // Return to normal size
    });

    // Trigger the Google sign-in process
    UserCredential? userCredential = await signInWithGoogle();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainPageScreen()),
    );
    }
}
