import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qantara/core/helpers/extentios/extention.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/di/cubit/cubit.dart';
import '../../core/di/cubit/states.dart';
import '../../core/routing/router.dart';
import '../../core/theming/colors.dart';
import '../../core/theming/styles.dart';
import '../../core/widgets/default_button.dart';
class ChoseProductScreen extends StatefulWidget {
  const ChoseProductScreen({super.key});

  @override
  State<ChoseProductScreen> createState() => _ChoseProductScreenState();
}

class _ChoseProductScreenState extends State<ChoseProductScreen> {
  int _currentIndex = 0;
  Map<String,dynamic>? car;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitApp,StateApp>(
        listener: (context,state){

        },
        builder:  (context,state){
          var cubit=CubitApp.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text("سعّرها معنا ", style: TextStyles.font20BlackBold),
              centerTitle: true,
            ),
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10.h,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 25.0.w),
                      child: Text("اختار المركبه",style: TextStyles.font20BlackBold,),
                    ),
                    Column(
                      spacing: 30.h,
                      children: [
                        CarouselSlider(
                          items: [
                            ...cubit.cars
                                .map((e) => Container(
                              width: double.infinity,
                              height: 220.h,
                              padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 10.w),
                              decoration: BoxDecoration(
                                  color: ColorsManager.greyBlackColor,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                spacing: 15.w,
                                children: [
                                  Image.asset(e["brand"], width: 90.w),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("رقم الهيكل", style: TextStyles.font18WhiteBold),
                                              Text(e["number"], style: TextStyles.font18GreyBold),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Column(
                                                children: [
                                                  Text("الفئة", style: TextStyles.font18WhiteBold),
                                                  Text(e["category"], style: TextStyles.font18GreyBold),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text("موديل", style: TextStyles.font18WhiteBold),
                                                  Text(e["model"], style: TextStyles.font18GreyBold),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
                          ],
                          options: CarouselOptions(
                            height: 250.h,
                            initialPage: 0,
                            reverse: true,
                            enlargeCenterPage: true,
                            disableCenter: true,
                            enableInfiniteScroll: false,
                            viewportFraction: 1.0,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentIndex = index; // Update current index
                              });
                            },
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: SmoothPageIndicator(
                            controller: PageController(initialPage: _currentIndex),
                            effect: ExpandingDotsEffect(
                              dotWidth: 10,
                              dotHeight: 5,
                              spacing: 5,
                              expansionFactor: 4,
                              dotColor: Colors.grey,
                              activeDotColor:ColorsManager.primaryColor,
                            ),
                            count: cubit.cars.length,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                      defaultButton(event: (){
                        context.pushNamed(Routes.addProduct,arguments:cubit.cars[_currentIndex]);
                      }, text:Text("التالي",style: TextStyles.font18BrownRegular,))
                  ],
                ),
              ),
            ),
          );});
  }
}