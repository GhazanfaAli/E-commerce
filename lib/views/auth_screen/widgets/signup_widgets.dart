import 'package:e_commerce/config/components/round_button.dart';
import 'package:e_commerce/views/auth_screen/widgets/custom_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/auth_bloc/bloc/auth_bloc.dart';

class UsernameInputWidget extends StatelessWidget {
  final TextEditingController controller;

  const UsernameInputWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller,
      hintText: 'Username',
      prefixIcon: const Icon(Icons.person_outline,color: Colors.blue),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your name';
        }
        return null;
      },
    );
  }
}

class EmailInputWidget extends StatelessWidget {
  final TextEditingController controller;

  const EmailInputWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller,
      hintText: 'Email',
      prefixIcon: const Icon(Icons.email_outlined,color: Colors.blue),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        return null;
      },
    );
  }
}

class PasswordInputWidget extends StatelessWidget {
  final TextEditingController controller;

  const PasswordInputWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller,
      hintText: 'Password',
      prefixIcon: const Icon(Icons.lock_clock_outlined, color: Colors.blue,),
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
    );
  }
}

class CountryInputWidget extends StatelessWidget {
  final TextEditingController controller;

  const CountryInputWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller,
      hintText: 'Country',
      prefixIcon: const Icon(Icons.flag_outlined,color: Colors.blue),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your country name';
        }
        return null;
      },
    );
  }
}
class SignUpButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController usernameController;
  final TextEditingController countryController;

  const SignUpButton({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.usernameController,
    required this.countryController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        bool isLoading = state is LoadingState;

        return RoundButton(
          title: 'Signup',
          onPress: () {
            if (formKey.currentState!.validate()) {
              context.read<AuthBloc>().add(
                SignUpRequested(
                  username: usernameController.text,
                  country: countryController.text,
                  email: emailController.text,
                  password: passwordController.text,
                ),
              );
            }
          },
          height: 50,
          width: double.infinity,
          loading: isLoading,
        );
      },
    );
  }
}
