import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qantara/core/di/cubit/states.dart';
import 'package:qantara/core/networking/local/cache_helper.dart';
import 'package:qantara/core/theming/colors.dart';

import 'core/di/cubit/cubit.dart';
import 'core/routing/app_router.dart';
import 'core/routing/router.dart';

class QantaraApp extends StatelessWidget {
  final AppRouter appRouter;
  const QantaraApp({super.key, required this.appRouter});
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
        create: (BuildContext context) => CubitApp()..createDatabaseAndTable(),
        child: BlocConsumer<CubitApp,StateApp>(
        listener: (context,state){
    },
    builder:  (context,state){
    return ScreenUtilInit(
              designSize: const Size(393, 852),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (_, child) {
                return MaterialApp(
                  title: 'Qantara',
                  theme: ThemeData(
                    primaryColor: ColorsManager.primaryColor,
                    fontFamily: "ibm",
                    scaffoldBackgroundColor: Colors.white,
                  ),
                  debugShowCheckedModeBanner: false,
                  initialRoute: Routes.splashScreen,
                  onGenerateRoute: appRouter.generateRoute,
                );
              });}));
  }
}
