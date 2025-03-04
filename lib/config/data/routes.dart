import 'package:e_commerce/config/data/routes_name.dart';

import 'package:e_commerce/views/views.dart';
import 'package:flutter/material.dart';





class Routes{
  
  static Route<dynamic> generateRoute(RouteSettings settings){

    switch (settings.name) {
      
      case RoutesName.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case RoutesName.loginScreen:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case RoutesName.homehScreen:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case RoutesName.searchScreen:
    //    return MaterialPageRoute(builder: (context) => SearchProductScreen());  
      case RoutesName.cartScreen:
     //   return MaterialPageRoute(builder: (context) => CartScreen());  
      case RoutesName.userProfileScreen:
       // return MaterialPageRoute(builder: (context) => UserProfileScreen());  
        
        default:
       return MaterialPageRoute(builder: (context) {
            return const Scaffold(
              body: Center(child: Text('No route generated'),),
            );
          });
    }
  }

}