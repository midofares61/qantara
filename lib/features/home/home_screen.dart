import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qantara/core/networking/local/cache_helper.dart';
import 'package:qantara/core/theming/colors.dart';

import '../../core/di/cubit/cubit.dart';
import '../../core/di/cubit/states.dart';
import '../../core/theming/styles.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(CubitApp.get(context).user==null){
    CubitApp.get(context).getUser(phone: CacheHelper.getData(key: "phone"));
    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitApp,StateApp>(
    listener: (context,state){

        },
        builder:  (context,state){
      var cubit=CubitApp.get(context);
        return Scaffold(
          body:cubit.screens[cubit.currentIndex] ,
          bottomNavigationBar: BottomNavigationBar(

    backgroundColor: Colors.white,
    currentIndex: cubit.currentIndex,
      onTap: (value){
      cubit.changeIndex(value);
      },
      items: [
    BottomNavigationBarItem(icon: cubit.currentIndex==0?SvgPicture.asset("assets/images/home_active.svg",width: 25,height: 25,):SvgPicture.asset("assets/images/home.svg",width: 25,height: 25,),label: "",),
    BottomNavigationBarItem(icon:cubit.currentIndex==1?SvgPicture.asset("assets/images/talabat_active.svg",width: 25,height: 25,):Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset("assets/images/talabat.svg",width: 25,height: 25,),
        ),
        if(cubit.orders!=null)
          Container(
            decoration: BoxDecoration(
              color: ColorsManager.primaryColor,
              borderRadius: BorderRadius.circular(50)
            ),
            padding: EdgeInsets.symmetric(horizontal: 5,vertical: 1),
            child: Text("${cubit.orders!.length}",style: TextStyle(fontSize: 10.sp),),
          )
      ],
    ),label: ""),
    BottomNavigationBarItem(icon:cubit.currentIndex==2?SvgPicture.asset("assets/images/user.svg",width: 25,height: 25,):SvgPicture.asset("assets/images/user_active.svg",width: 25,height: 25,),label: ""),
          ]),
        );});
  }
}
