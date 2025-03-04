import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'auth_event.dart';
part 'auth_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  AuthBloc() : super(InitialState()) {
    on<SignUpRequested>(_onSignup);
    on<LoginRequested>(_onLogin);
  }

  Future<void> _onSignup(SignUpRequested event, Emitter<AuthState> emit) async{

    emit(LoadingState());

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      User? user = userCredential.user;
print("User signed in: ${userCredential.user?.uid}");
      await _fireStore.collection('users').doc(user!.uid).set({
        'username': event.username,
        'email': event.email,
        'password':event.password,
        'country': event.country,
      });

      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }

  }

   Future<void> _onLogin(LoginRequested event, Emitter<AuthState> emit) async {
    
    emit(LoadingState());

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      User? user = userCredential.user;

      emit(AuthAuthenticated(user!));
    } catch (e) {

      emit(AuthError(e.toString()));
    }
  }
}
