import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

   // Sign in to Firebase with the Google credentials
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    // Save user to Firestore
    await saveGoogleUserToFirestore(userCredential.user);

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
  
}




Future<void> saveGoogleUserToFirestore(User? user) async {
  if (user != null) {
    final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);
    
    // Check if user already exists
    final docSnapshot = await userDoc.get();
    
    if (!docSnapshot.exists) {
      // If the user doesn't exist in Firestore, add them
      await userDoc.set({
        'username': user.displayName ?? 'Unknown',
        'email': user.email ?? 'Unknown',
      
      });
    }
  }
}
