part of 'auth_bloc.dart';

class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
  
}

class SignUpRequested extends AuthEvent {
  final String username;
  final String email;
  final String password;
  final String country;

  SignUpRequested({required this.username, required this.email, required this.password, required this.country});

  @override
  List<Object?> get props => [username, email, password, country];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}