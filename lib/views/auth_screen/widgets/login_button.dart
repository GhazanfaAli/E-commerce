import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/blocs/auth_bloc/bloc/auth_bloc.dart';
import 'package:e_commerce/config/components/round_button.dart';

class SubmitButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const SubmitButton({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        // Determine if loading spinner should be shown
        bool isLoading = state is LoadingState;

        return RoundButton(
          title: 'Login',
          onPress: () {
            if (formKey.currentState!.validate()) {
              // Dispatch login event when form is validated
              context.read<AuthBloc>().add(
                LoginRequested(
                  email: emailController.text,
                  password: passwordController.text,
                ),
              );
            }
          },
          height: 50,
          width: double.infinity,
          loading: isLoading,  // Show loading indicator if loading
        );
      },
    );
  }
}
