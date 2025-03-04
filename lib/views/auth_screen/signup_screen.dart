import 'dart:ui';
import 'package:e_commerce/views/auth_screen/login_screen.dart';
import 'package:e_commerce/views/auth_screen/widgets/signup_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/auth_bloc/bloc/auth_bloc.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Scaffold(
        body: LayoutBuilder( // Wrap everything inside a LayoutBuilder
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight, // Ensure the child takes up at least the entire height
                ),
                child: IntrinsicHeight(
                  child: Stack(
                    children: [
                      _backgroundGradients(context),
                      _foregroundWidgets(context),
                    ],
                  ),
                ),
              ),
            );
          },
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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _signUpTitle(),
            const SizedBox(height: 20),
            _signUpForm(),
            const SizedBox(height: 20),
            _divider(),
            const SizedBox(height: 20),
            _loginOption(context),
          ],
        ),
      ),
    );
  }

  Widget _signUpTitle() {
    return const Text(
      'Create Your Account',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        height: 1.5,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _signUpForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          UsernameInputWidget(controller: _userController),
          const SizedBox(height: 20),
          EmailInputWidget(controller: _emailController),
          const SizedBox(height: 20),
          PasswordInputWidget(controller: _passwordController),
          const SizedBox(height: 20),
          CountryInputWidget(controller: _countryController),
          const SizedBox(height: 20),
          SignUpButton(
            formKey: _formKey,
            emailController: _emailController,
            passwordController: _passwordController,
            usernameController: _userController,
            countryController: _countryController,
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

  Widget _loginOption(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account?",
          style: TextStyle(color: Colors.white),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
          child: const Text(
            'Login',
            style: TextStyle(color: Colors.blueAccent), // Color for the button
          ),
        ),
      ],
    );
  }
}
