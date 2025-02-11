import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qantara/core/di/models/order_model.dart';
import 'package:qantara/core/di/models/price_model.dart';
import 'package:qantara/core/routing/router.dart';
import 'package:qantara/features/addCar/add_car_screen.dart';
import 'package:qantara/features/add_product/chosse_product_screen.dart';
import 'package:qantara/features/checkout/checkout_screen.dart';
import 'package:qantara/features/login/login_screen.dart';
import 'package:qantara/features/login/otb_screen.dart';
import 'package:qantara/features/pricing/pricing_screen.dart';
import 'package:qantara/features/splash_screen/splah_screen.dart';

import '../../features/add_product/add_product_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/onBoarding/onboarding_screen.dart';

class AppRouter{

  Route generateRoute(RouteSettings setting){
    switch(setting.name){
      case Routes.onBoardingScreen:
        return MaterialPageRoute(
            builder: (_)=>OnBoardingScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(
            builder: (_)=>LoginScreen());
        // case Routes.otbScreen:
        // return MaterialPageRoute(
        //     builder: (_)=>OtbScreen());
        case Routes.homeScreen:
        return MaterialPageRoute(
            builder: (_)=>HomeScreen());
        case Routes.addCar:
        return MaterialPageRoute(
            builder: (_)=>AddCarScreen());
        case Routes.pricing:
          final data = setting.arguments as OrderModel;
        return MaterialPageRoute(
            builder: (_)=>PricingScreen(order: data,));
        case Routes.checkout:
          final data = setting.arguments as PriceModel;
        return MaterialPageRoute(
            builder: (_)=>CheckoutScreen(order: data,));
        case Routes.splashScreen:
        return MaterialPageRoute(
            builder: (_)=>SplashScreen());
        case Routes.choseProduct:
        return MaterialPageRoute(
            builder: (_)=>ChoseProductScreen());
        case Routes.addProduct:
          final data = setting.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
            builder: (_)=>AddProductScreen(car: data,));
      default:
        return MaterialPageRoute(
            builder:(_)=>Scaffold(
              body:  Center(
                child: Text("No route defined for ${setting.name}"),
              ),
            ) );
    }
  }
}