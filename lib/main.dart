import 'package:e_commerce/blocs/home_bloc/home_bloc.dart';
import 'package:e_commerce/config/data/services/constants.dart';
import 'package:e_commerce/respository/products/product_http_api_response.dart';
import 'package:e_commerce/respository/products/product_repository.dart';
import 'package:e_commerce/views/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

GetIt getIt = GetIt.instance;
void main() async{

WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp]
  );
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBsBQn_GJH5Km7ue6nn6zS5lJQgb1MME5s", 
      appId: "1:193179656108:android:4f38435bb435ddaf8a6409", 
      messagingSenderId: "193179656108", 
      projectId: "e-commerce-43ada",
      storageBucket: "e-commerce-43ada.appspot.com"
    ),
  );

  await _setup();
  serviceLocator();
  runApp(const MyApp());
}
Future<void> _setup()async{
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePubishableKey;
   await Stripe.instance.applySettings();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ProductRepository productRepository = getIt<ProductRepository>();
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(create: (BuildContext context) => HomeBloc(productRepository: productRepository))
      ], 
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    ));
  }

}
void serviceLocator(){
 // getIt.registerLazySingleton<ProductRepository>(() => ProductHttpApiResponse());
   getIt.registerLazySingleton<ProductRepository>(() => ProductHttpApiResponse());
}

