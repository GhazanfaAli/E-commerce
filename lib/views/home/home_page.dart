import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:lottie/lottie.dart';
import 'package:e_commerce/blocs/home_bloc/home_bloc.dart';
import 'package:e_commerce/main.dart';
import 'package:e_commerce/utils/enums.dart';
import 'package:e_commerce/views/detail_screen/detail_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc homeBloc;
  
  List<String> imageList = [
    'https://img.pikbest.com/origin/05/66/81/74tpIkbEsTghn.jpg!w700wp',
  'https://maleemaindia.com/wp-content/uploads/2024/04/Banner-for-clothing-06.jpg',
  'https://thumbs.dreamstime.com/b/sale-promotion-banner-cricket-season-illustration-49950785.jpg',
'https://www.dukeindia.com/cdn/shop/files/Banner_2_d986a525-a847-4e44-8da6-9d8b8f7c11e7.jpg?v=1723872360',
'https://c8.alamy.com/comp/2RXBM2E/mid-season-sale-up-to-50-off-sign-in-a-shop-window-displaying-mens-clothing-glasgow-scotland-uk-europe-2RXBM2E.jpg',
'https://www.shutterstock.com/image-photo/sale-sign-on-cloth-store-600nw-436393411.jpg',
  'https://news.lenovo.com/wp-content/uploads/2024/02/0416-1024x683.jpg',
  'https://i.pinimg.com/736x/0a/33/98/0a3398bcbe0297ca8102ea346de7c516.jpg',
  'https://www.watsons.com/media/wysiwyg/C2415NFA_G1_Block_Secondary6.jpg',
  'https://www.thefashionisto.com/wp-content/uploads/2023/08/Bomber-Jacket-Outfits-Men.jpg',
  'https://www.theballs.in/wp-content/uploads/2023/01/Cricket-Shoes-Online-with-50-Off-860x445.jpg',
  'https://as2.ftcdn.net/v2/jpg/05/01/56/19/1000_F_501561996_vICV6nqNAngNZbguqro5cS3a8t00nMjv.jpg',
  'https://i0.wp.com/uchify.com/wp-content/uploads/2024/05/Uchify-Sams-cover-images-53.jpg?resize=1080%2C565&ssl=1',
  'https://www.livemint.com/lm-img/img/2024/06/24/600x338/best_gaming_laptop_1719212951650_1719212965476.jpg',
  //'https://images-eu.ssl-images-amazon.com/images/G/31/img24/Sports/April/Coop/Jaspo/cricket_1242_x_450_px.png'
  //'https://www.hindustantimes.com/ht-img/img/2024/09/04/550x309/pexels-pixabay-276528_1725434095298_1725434103217.jpg'
  ];

  List<String> categoryList = ['All', 'Furniture', 'Clothes', 'Electronics', 'Sports'];
  static const String productApi = 'http://10.11.56.43:8000/api/productModel/';
  List<String> categoryUrls = [
    productApi,
    '${productApi}categories/Furniture/',
    '${productApi}categories/Clothes/',
    '${productApi}categories/Electronics/',
    '${productApi}categories/Sports/',
  ];

  String formatPriceWithDollarSign(double price) {
  return "\$ ${price.toStringAsFixed(2)}"; // Format to two decimal places
}
  String newCategory = "All";
 

  @override
  void initState() {
    super.initState();
    homeBloc = HomeBloc(productRepository: getIt());
    context.read<HomeBloc>().add(FetchedProduct(categoryUrl: productApi));
  }

  @override
  void dispose() {
    homeBloc.close();
    super.dispose();
  }

  //int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
  elevation: 0,
  flexibleSpace: Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
           Colors.white.withOpacity(0.8), // White with some opacity
          Colors.grey.withOpacity(0.6),   // Grey with some opacity
          const Color.fromARGB(73, 0, 0, 0).withOpacity(0.4),  // Dim black with some opacity
          ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
  ),
  title: ShaderMask(
    shaderCallback: (bounds) {
      return const LinearGradient(
        colors: [Colors.orange, Colors.pink],
      ).createShader(bounds);
    },
    child: AnimatedTextKit(
      repeatForever: true,
      animatedTexts: [
        TypewriterAnimatedText(
          'Welcome to',
          textStyle: GoogleFonts.kaushanScript(
            fontSize: 37,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          speed: const Duration(milliseconds: 100),
        ),
        TypewriterAnimatedText(
          'E-Commerce',
          textStyle: GoogleFonts.kaushanScript(
            fontSize: 37,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          speed: const Duration(milliseconds: 100),
        ),
        TypewriterAnimatedText(
          'app',
          textStyle: GoogleFonts.kaushanScript(
            fontSize: 37,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          speed: const Duration(milliseconds: 100),
        ),
      ],
    ),
  ),
  actions: [
    Container(
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.width * 0.2,
      margin: const EdgeInsets.only(left: 5, bottom: 5, top: 5),
      child: const CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(
          'https://media.istockphoto.com/id/1364917563/photo/businessman-smiling-with-arms-crossed-on-white-background.jpg?b=1&s=612x612&w=0&k=20&c=zVcDnGEyoHJXgsIVBLapEoAqNEr9nUlmooClC5j_218=',
        ),
      ),
    ),
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
        child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    CarouselSlider.builder(
                      itemCount: imageList.length,
                      options: CarouselOptions(
                        height: 170,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlay: true,
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                        viewportFraction: 0.7,
                      ),
                      itemBuilder: (context, index, realIdx) {
                        return Container(
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: CachedNetworkImage(
          imageUrl: imageList[index],
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
            ),
          ),
          placeholder: (context, url) => SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Shimmer.fromColors(
            baseColor: const Color.fromARGB(223, 186, 186, 186), // Soft light grey for base
            highlightColor: const Color.fromARGB(199, 255, 255, 255), // White for a smooth highlight effect
            child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
            ),
          ),
        )
        
        ,
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        
        
                          ),
                        );
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: ListView.builder(
                        itemCount: categoryList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              newCategory = categoryUrls[index];
                             context.read<HomeBloc>().add(FetchedProduct(categoryUrl: newCategory));
                       
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 6,left: 6),
                              child: Container(
                                
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  child: Center(child: Text(categoryList[index], style: GoogleFonts.montserrat(
                                  // fontSize: 37,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  
                                   )
                                      ,)),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.productList.status == Status.LOADING) {
            return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.height * 0.2,
                    child: Lottie.network('https://lottie.host/913ac93d-4af6-4c59-9934-c08e076fad3c/9Qbaayb9Pv.json')
                );
          }
        
          if (state.productList.status == Status.ERROR) {
            return Center(child: Text(state.productList.message ?? 'An error occurred'));
          }
        
          if (state.productList.data == null || state.productList.data!.isEmpty) {
            return Center(
              child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.network('https://lottie.host/913ac93d-4af6-4c59-9934-c08e076fad3c/9Qbaayb9Pv.json'),
                          Text('Loading...', style: GoogleFonts.roboto(fontWeight: FontWeight.w600),)
                        ],
                      )
                  ),
            );
          }
        
          final images = state.productList.data!;
        
          
        
          return Container(
            decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2), // Adjust the shadow color and opacity
        offset: const Offset(0, 4), // Vertical shadow offset
        blurRadius: 8, // Shadow blur radius
        spreadRadius: 1, // Shadow spread radius
      ),
    ],
  ),
            margin: const EdgeInsets.symmetric(horizontal:8),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                 mainAxisSpacing: 10,  // Vertical space between grid items
                crossAxisSpacing: 10,
                crossAxisCount:2,
                childAspectRatio: 7 / 9,
              ),
              itemCount: images.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final image = images[index].productUrl ?? 'https://default-image-url.com';
                final priceWithDollarSign = images[index].productprice ?? "\$99";
                final priceWithoutDollarSign = priceWithDollarSign.replaceAll("\$", "");
                final productPriceDouble = double.tryParse(priceWithoutDollarSign) ?? 99.0;
                final description = images[index].productDescription ?? 'No description available';
                final title = images[index].producttitle ?? 'Untitled Product';
                 final formattedPrice = formatPriceWithDollarSign(productPriceDouble);
                   
            
            
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPageScreen(imageUrl: image, title: title, price: productPriceDouble, description: description),
                      ),
                    );
                  },
                  child: Card(
                        elevation: 0, // Set elevation to 0, since we are using BoxDecoration for shadow
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0), // Make sure the card has the same border radius
    ),

                    child: Column(
                      children: [
                
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: CachedNetworkImage(
              imageUrl: image,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
                ),
              ),
              placeholder: (context, url) => SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!, 
                highlightColor: Colors.white, 
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                formattedPrice,
                                style: const TextStyle(color: Colors.green, fontSize: 14),
                              ),
                              const Row(children: [
                              Icon(Icons.star, color: Colors.orange, size: 15,),
                              Icon(Icons.star, color: Colors.orange,size: 15),
                              Icon(Icons.star, color: Colors.orange,size: 15),
                              Icon(Icons.star, color: Colors.orange,size: 15),
                              Icon(Icons.star_half, color: Colors.orange,size: 15),
                              ],)
                              
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
        },
            )
         
                    ],
                ),
              ),
      )
         
    );
  }
}

