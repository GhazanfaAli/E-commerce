import 'package:e_commerce/views/order_screen/order_screen.dart';
import 'package:e_commerce/views/user_profile/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/views/home/home_page.dart';
import 'package:e_commerce/views/search_product/search_product_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainPageScreen extends StatefulWidget {
  const MainPageScreen({super.key});

  @override
  State<MainPageScreen> createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0; // Track the selected index

  @override
  void dispose() {
    _pageController.dispose(); // Dispose of the PageController
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
    _pageController.jumpToPage(index); // Jump to the selected page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index; // Update the selected index when page changes
          });
        },
        children: <Widget>[
          const HomePage(),
          const ProductSearchScreen(),
          const OrderScreen(),
          MyProfileScreen(),
          // Add any additional screens as necessary
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
             Colors.blue[900]!, // Start with a deep blue
              Colors.blue[800]!, // Transition to a rich blue
              Colors.blueAccent,
            ],
           begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.0, 0.5, 1.0], // Adjust stops for deeper effect
          ),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)), // More rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Light shadow for elevation
              blurRadius: 20,
              offset: const Offset(0, -2), // Shadow position
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
          child: GNav(
            gap: 10, // Increased gap between items
            activeColor: Colors.white, // Active icon color
            iconSize: 30, // Increased size of icons
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Adjusted padding
            tabBackgroundColor: Colors.white.withOpacity(0.3), // Background color for active tab
            color: Colors.white70, // Inactive icon color
            tabs: [
              GButton(
                icon: Icons.home,
                text: "Home",
                iconColor: _selectedIndex == 0 ? Colors.white : Colors.white70,
              ),
              GButton(
                icon: Icons.search,
                text: "Search",
                iconColor: _selectedIndex == 1 ? Colors.white : Colors.white70,
              ),
              GButton(
                icon: Icons.shopping_cart_outlined,
                text: "Cart",
                iconColor: _selectedIndex == 2 ? Colors.white : Colors.white70,
              ),
              GButton(
                icon: Icons.person,
                text: "Profile",
                iconColor: _selectedIndex == 3 ? Colors.white : Colors.white70,
              ),
            ],
            selectedIndex: _selectedIndex, // Set the selected index
            onTabChange: _onItemTapped, // Call the tap handler
            rippleColor: Colors.white.withOpacity(0.5), // Ripple effect color
            backgroundColor: Colors.transparent, // Make the background transparent
            curve: Curves.easeInOut, // Animation curve
            duration: const Duration(milliseconds: 300), // Animation duration
          ),
        ),
      ),
      extendBody: true,
    );
  }
}
