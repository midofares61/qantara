import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qantara/core/helpers/extentios/extention.dart';
import 'package:qantara/core/theming/colors.dart';
import 'package:qantara/core/widgets/default_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/di/cubit/cubit.dart';
import '../../../core/di/cubit/states.dart';
import '../../../core/routing/router.dart';
import '../../../core/theming/styles.dart';

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({super.key});

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  final CarouselController _carouselController = CarouselController();

  int _currentIndex = 0;
  List<Map<String,dynamic>> list=[
    {
      "title":"اسرع توصيل",
      "subTitle":"خلال يومين يوصل طلبك",
      "image":Image.asset("assets/images/caresole_1.png"),
    },
    {
      "title":"قربنا لك التشاليح",
      "subTitle":"بنقرة مع قنطرة",
      "image":Image.asset("assets/images/caresole_3.png"),
    },
    {
      "title":"تجيك أكثر من تسعيرة",
      "subTitle":"ومعنا لاتشيل هم الضمان",
      "image":SvgPicture.asset("assets/images/caresole_3.svg"),
    }
  ];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitApp,StateApp>(
        listener: (context,state){

    },
    builder:  (context,state){
    var cubit=CubitApp.get(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leadingWidth: 60,
          leading: Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: Image.asset(
              "assets/images/qantara.png",
              fit: BoxFit.cover,
              width: 50.w,
              height: 50.h,
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5,
            children: [
              Text(
                "اهلا بك",
                style: TextStyles.font20BlackBold,
              ),
              Text(
                "اهلا بك في  قنطرة",
                style: TextStyles.font12GreyBold,
              ),
            ],
          ),
          actions: [
            CircleAvatar(
              backgroundColor: ColorsManager.secondPrimaryColor,
              radius: 25,
              child: Text(
                "A",
                style: TextStyles.font20BlackBold,
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: SingleChildScrollView(
            child: Column(
              spacing: 50.h,
              children: [
                ConditionalBuilder(condition: cubit.cars.isEmpty, builder: (context)=>Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: double.infinity,
                        height: 220.h,
                        padding:  EdgeInsets.symmetric(vertical:10.0.w),
                        decoration: BoxDecoration(
                            color: ColorsManager.greyBlackColor,
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          children: [
                            Expanded(
                                child: Column(
                                  spacing: 10.h,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "سهلناها عليك تقـــــدر ",
                                          style: TextStyles.font18WhiteBold,
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "تضــــــــــــــــــــــــــــــــــــــــــــــيف ",
                                          style: TextStyles.font18WhiteBold,
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "سيارتك بسهولــــــــــــــــــ ",
                                          style: TextStyles.font18WhiteBold,
                                        )
                                      ],
                                    ),
                                  ],
                                )),
                            Expanded(
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 10.h),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        width: 80,

                                        child: TextButton(
                                            onPressed: (){
                                              context.pushNamed(Routes.addCar);
                                            },
                                            style: ButtonStyle(
                                                backgroundColor: WidgetStateProperty.all(ColorsManager.primaryColor),
                                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                minimumSize: WidgetStateProperty.all(
                                                    const Size(double.infinity,35)
                                                ),
                                                shape: WidgetStateProperty.all(
                                                    RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(6)
                                                    )
                                                )
                                            ),
                                            child: Text("اضافة",style: TextStyles.font18BlackBold,)
                                        ),
                                      )
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(bottom: 30.h),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/images/home_add.svg",
                            width: 180,
                          ),
                          Text("ـــــه",style: TextStyles.font16WhiteBold,textDirection: TextDirection.ltr,)
                        ],
                      ),
                    )
                  ],
                ), fallback: (context)=> Column(
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
                        InkWell(
                          onTap: (){
                            context.pushNamed(Routes.addCar);
                          },
                          child: Container(
                            width: double.infinity,
                            height: 220.h,
                            padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 10.w),
                            decoration: BoxDecoration(
                                color: ColorsManager.greyBlackColor,
                                borderRadius: BorderRadius.circular(12)),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 10.h,
                                children: [
                                  Container(
                                      padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 10.w),
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(50)),
                                      child: Icon(Icons.add,size: 50,)),
                                  Text("اضافة سياره اخرى",style: TextStyles.font20WhiteBold,)
                                ],
                              ),
                            ),
                          ),
                        )
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
                        count: cubit.cars.length+1,
                      ),
                    ),
                  ],
                )),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  width: double.infinity,
                  child: Column(
                    spacing: 15.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("خدمتنا",style: TextStyles.font22BlackBold,),
                      CarouselSlider(
                        items: list
                            .map((e) => Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: ColorsManager.primaryColor,
                            borderRadius: BorderRadius.circular(12)
                          ),
                          child: Row(
                            children: [
                              e["image"],
                              Expanded(child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 5.h,
                                children: [
                                  Text(e["title"],style: TextStyles.font20BlackBold,),
                                  Text(e["subTitle"],style: TextStyles.font16BrownRegular,),
                                ],
                              ))
                            ],
                          ),
                        ))
                            .toList(),
                        options: CarouselOptions(
                          height: 110,
                          autoPlay: true,
                          autoPlayAnimationDuration: Duration(seconds: 1),
                          autoPlayInterval: Duration(seconds: 3),
                          initialPage: 0,
                          reverse: true,
                          enlargeCenterPage: true,
                          disableCenter: true,
                          enableInfiniteScroll: true,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          viewportFraction: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  width: double.infinity,
                  child: Column(
                    spacing: 15.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("طلب تسعيرة",style: TextStyles.font22BlackBold,),
                      TextButton(
                          onPressed: (){
                            context.pushNamed(Routes.choseProduct);
                          },
                          style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(ColorsManager.primaryColor),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              minimumSize: WidgetStateProperty.all(
                                   Size(double.infinity,70.h)
                              ),
                              shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)
                                  )
                              )
                          ),
                          child: Text("سعّرها معنا",style: TextStyles.font22BlackBold,)
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );});
  }
}
