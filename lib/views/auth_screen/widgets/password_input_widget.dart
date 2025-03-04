import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/blocs/auth_bloc/bloc/auth_bloc.dart';
import 'package:e_commerce/views/auth_screen/widgets/custom_field.dart';

class PasswordInputWidget extends StatelessWidget {
  final TextEditingController controller;

  const PasswordInputWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return CustomTextFormField(
          controller: controller,
          hintText: 'Password',
          prefixIcon: const Icon(Icons.lock_outline_rounded, color: Colors.grey,),
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            return null;
          },
        );
      },
    );
  }
}
