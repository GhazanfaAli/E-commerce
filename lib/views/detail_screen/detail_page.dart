import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/config/components/round_button.dart';
import 'package:e_commerce/config/data/services/stripe_service/stripe_service.dart';
import 'package:e_commerce/views/order_screen/order_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class DetailPageScreen extends StatefulWidget {
  final String imageUrl;
  final String title;
  final double price;
  final String description;

  const DetailPageScreen({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.description,
  });

  @override
  _DetailPageScreenState createState() => _DetailPageScreenState();
}

class _DetailPageScreenState extends State<DetailPageScreen> {
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  final databaseRef = FirebaseFirestore.instance.collection('products');

  Future<void> uploadingData() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        String id = DateTime.now().millisecondsSinceEpoch.toString();
        await databaseRef.doc(id).set({
          'product_image': widget.imageUrl,
          'product_title': widget.title,
          'product_price': widget.price,
          'product_description': widget.description,
          'product_id': id,
        });
      } catch (e) {
        print("Error uploading data: $e");
      }
    } else {
      print("User is not authenticated. Cannot upload data.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // Product Image with Gradient Overlay
                Container(
                  height: MediaQuery.of(context).size.height * 0.45,
                  decoration: BoxDecoration(

                    image: DecorationImage(
                      image: NetworkImage(widget.imageUrl),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.only(
                      // bottomLeft: Radius.circular(30.0),
                      // bottomRight: Radius.circular(30.0),
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 16,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Title
                  Text(
                    widget.title,
                    style: GoogleFonts.notoSans(
                                   fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Product Reviews and Ratings Row
                  Row(
                    children: [
                      // Rating Box
                      _buildInfoBox(
                        icon: Icons.star,
                        label: '4.8',
                        sublabel: '117 reviews',
                        iconColor: Colors.orange,
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                      // Thumbs Up Box
                      _buildInfoBox(
                        icon: Icons.thumb_up_alt_rounded,
                        label: '94%',
                        sublabel: 'Positive',
                        iconColor: Colors.green,
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                      // Comments Box
                      _buildInfoBox(
                        icon: Icons.message_sharp,
                        label: '8',
                        sublabel: 'Comments',
                        iconColor: Colors.blueAccent,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Discount and Animated Text
                  Row(
                    children: [
                      const Image(
                        height: 50,
                        width: 50,
                        image: AssetImage('assets/discount.png'),
                      ),
                      const SizedBox(width: 10),
                      DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.orange,
                        ),
                        child: AnimatedTextKit(
                          repeatForever: true,
                          animatedTexts: [
                            TypewriterAnimatedText('Limited Time Offer!'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Description
                  ReadMoreText(
                    widget.description,
                    trimLines: 3,
                    style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Read more',
                    trimExpandedText: 'Show less',
                    moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                  const SizedBox(height: 17),

                  // Price and Buy Now Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${widget.price.toString()}',
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      RoundButton(
                        title: 'Buy Now',
                        onPress: () async {
                          try {
                            await StripeServices.instance.makePayment(
                              amount: (widget.price).toInt(),
                              currency: 'usd',
                              productName: widget.title,
                            );
                            await uploadingData();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const OrderScreen()),
                            );
                          } catch (e) {
                            print("Error: $e");
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Payment Error'),
                                content: const Text('There was an error processing the payment. Please try again.'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.6,
                        gradient:const LinearGradient(colors: [Colors.orange, Colors.pink]) ,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBox({required IconData icon, required String label, required String sublabel, required Color iconColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade100,
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                sublabel,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
