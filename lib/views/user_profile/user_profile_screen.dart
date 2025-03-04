import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProfileScreen extends StatelessWidget {
  
  final user = FirebaseAuth.instance.currentUser;

   MyProfileScreen({super.key}); // Get the current user

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: GoogleFonts.lato(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.greenAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: user != null ? StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').doc(user!.uid).snapshots(), // Fetch the document based on the uid
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Some Error Occurred'));
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('No data available.'));
          } else {
            // Fetch user data from Firestore
            final userName = snapshot.data!['username'] ?? 'Unknown';
            final emailName = snapshot.data!['email'] ?? 'Unknown';

            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.lightBlueAccent.shade100],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  
                  // Profile Picture
                  const CircleAvatar(
                    radius: 60,
                    backgroundImage:AssetImage('assets/images.jpg'),
                    backgroundColor: Colors.white,
                  ),
                  const SizedBox(height: 20),
                  
                 
                  Text(
                    userName,
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue.shade900,
                    ),
                  ),
                  Text(
                    emailName,
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Profile Options
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        _buildProfileOption(context, Icons.person, 'Edit Profile'),
                        _buildProfileOption(context, Icons.history, 'Order History'),
                        _buildProfileOption(context, Icons.payment, 'Payment Methods'),
                        _buildProfileOption(context, Icons.settings, 'Settings'),
                        _buildProfileOption(context, Icons.logout, 'Log Out', color: Colors.red),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ) : const Center(child: Text('No user is logged in')),
    );
  }

  // Profile Option Builder
  Widget _buildProfileOption(BuildContext context, IconData icon, String title, {Color color = Colors.black}) {
    return GestureDetector(
      onTap: () {
        // Navigate to the corresponding screen
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent.withOpacity(0.2), Colors.greenAccent.withOpacity(0.2)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
