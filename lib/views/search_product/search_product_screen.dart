import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../blocs/home_bloc/home_bloc.dart';
import '../../config/data/response/api_response.dart';
import '../detail_screen/detail_page.dart';

class ProductSearchScreen extends StatefulWidget {
  const ProductSearchScreen({super.key});

  @override
  _ProductSearchScreenState createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  String formatPriceWithDollarSign(double price) {
    return "\$ ${price.toStringAsFixed(2)}"; 
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title:   Text(
          'Search Products',
          style: GoogleFonts.lato(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.greenAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.lightBlueAccent.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.productList.status == Status.LOADING) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.productList.status == Status.ERROR) {
              return Center(child: Text(state.productList.message ?? 'An error occurred'));
            }

            if (state.productList.data == null || state.productList.data!.isEmpty) {
              return const Center(child: Text('No data found'));
            }

            final images = state.productList.data!;

            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {}); 
                      },
                      decoration: InputDecoration(
                        labelText: 'Search by Title',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height - kToolbarHeight - 100,
                    child: ListView.builder(
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        final image = images[index].productUrl ?? 'https://via.placeholder.com/150';
                        final priceWithDollarSign = images[index].productprice ?? "\$99";
                        final priceWithoutDollarSign = priceWithDollarSign.replaceAll("\$", "");
                        final productPriceDouble = double.tryParse(priceWithoutDollarSign) ?? 99.0;
                        final title = images[index].producttitle ?? 'Untitled Product';
                        final formattedPrice = formatPriceWithDollarSign(productPriceDouble);
                        final description = images[index].productDescription ?? 'No description available';

                        if (searchController.text.isEmpty ||
                            title.toLowerCase().contains(searchController.text.toLowerCase())) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPageScreen(
                                      imageUrl: image,
                                      title: title,
                                      price: productPriceDouble,
                                      description: description),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                              child: Card(
                                elevation: 8,
                                shadowColor: Colors.grey.withOpacity(0.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                           gradient: LinearGradient(
            colors: [Colors.blueAccent.withOpacity(0.2), Colors.greenAccent.withOpacity(0.2)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 8,
                                              offset: Offset(0, 4),
                                              
                                            ),
                                          ],
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: image,
                                          imageBuilder: (context, imageProvider) => Container(
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
                                              decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) => const Icon(Icons.error),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              title,
                                              style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: const Color.fromARGB(255, 8, 92, 33),
                                              ),
                                            ),
                                            Text(
                                              formattedPrice,
                                              style: GoogleFonts.roboto(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color:Colors.orange
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox.shrink(); 
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
