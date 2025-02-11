import 'package:flutter/material.dart';
import 'package:qantara/core/helpers/extentios/extention.dart';

import '../../core/networking/local/cache_helper.dart';
import '../../core/routing/router.dart';
import '../../core/theming/colors.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 500)).then((_){
      CacheHelper.getData(key: "phone")!=null?context.pushNamedAndRemoveUntil(Routes.homeScreen, predicate: (Route<dynamic> route)=>false,):CacheHelper.getData(key: "onboarding")!=null? context.pushNamedAndRemoveUntil(Routes.loginScreen, predicate: (Route<dynamic> route)=>false,):context.pushNamedAndRemoveUntil(Routes.onBoardingScreen, predicate: (Route<dynamic> route)=>false,);
    });
    //
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsManager.secondPrimaryColor,
          leading: SizedBox(),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: ColorsManager.secondPrimaryColor,
          child: Center(
            child: Image.asset("assets/images/splash.png"),
          ),
        ),
      ),
    );
  }
}
