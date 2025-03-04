import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:badges/badges.dart' as badges;
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../blocs/search_catalog/order_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderBloc()..fetchProducts(),
      child: const OrderView(),
    );
  }
}

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Current Order',
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
        actions: [
          BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) {
              int badgeCount = 0;
              if (state is OrderProductsLoaded) {
                badgeCount = state.count;
              }
              return badges.Badge(
                badgeContent: Text(
                  badgeCount.toString(),
                  style: const TextStyle(fontSize: 11,color: Colors.white),
                ),
                badgeAnimation: const badges.BadgeAnimation.size(
                  animationDuration: Duration(seconds: 1),
                 // loopAnimation: true,
                  curve: Curves.linear,
                ),
                child: const Icon(Icons.shopping_cart_outlined, size: 29, color: Color.fromARGB(255, 82, 80, 80) ,),
              );
            },
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.03),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.lightBlueAccent.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Search by Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
                onChanged: (value) {
                  context.read<OrderBloc>().add(SearchProducts(value, 0));
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<OrderBloc, OrderState>(
                builder: (context, state) {
                  if (state is OrderInitial) {
                    // Replace the CircularProgressIndicator with a shimmer effect
                    return _buildShimmerEffect();
                  } else if (state is OrderProductsLoaded) {
                    return _buildProductList(state.products);
                  } else if (state is OrderProductsFiltered) {
                    return _buildProductList(state.filteredProducts);
                  } else if (state is OrderError) {
                    return Center(child: Text(state.message));
                  } else {
                    return const Center(child: Text('Unknown state'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductList(List<DocumentSnapshot> products) {
    if (products.isEmpty) {
      return const Center(child: Text('No matching results'));
    }

    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        var doc = products[index];
        String url = doc['product_image'] ?? '';
        String title = doc['product_title'] ?? 'No Title';
        double price = (doc['product_price'] ?? 0.0).toDouble();
        String id = doc['product_id'] ?? '0';

        return Card(
          elevation: 4, // Add shadow to the card
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('Order ID: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    const Spacer(),
                    Text(id, style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.orange,fontSize: 12)),
                  ],
                ),

                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildShimmerOrImage(url),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "\$$price",
                            style: const TextStyle(color: Colors.green,fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Status: On the way",
                            style: TextStyle(color: Colors.grey,fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildShimmerOrImage(String url) {
    if (url.isEmpty) {
      // Display a shimmer effect while the image is loading
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.white,
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }

    // Display a cached image with fallback to shimmer on loading
    return CachedNetworkImage(
      imageUrl: url,
      width: 100,
      height: 100,
      fit: BoxFit.cover,
      imageBuilder: (context, imageProvider) => Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.white,
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  Widget _buildShimmerEffect() {
    // Shimmer effect to replace CircularProgressIndicator when data is loading
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.white,
      child: ListView.builder(
        itemCount: 6, // Display shimmer placeholders for 6 items while loading
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 20,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 80,
                          height: 20,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 50,
                          height: 20,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
