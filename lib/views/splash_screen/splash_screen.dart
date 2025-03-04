import 'package:flutter/material.dart';
import 'package:e_commerce/config/data/services/firebase_services/firebase_services.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FireBaseServices splashScreen = FireBaseServices();

  @override
  void initState() {
    super.initState();

    // Using WidgetsBinding to ensure the first frame is rendered before navigation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 10), () {
        splashScreen.isLogin(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Splash Screen'),
      // ),
      body: Center(child: Lottie.asset('assets/loading_beautiful.json')),
    );
  }
}
