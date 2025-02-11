import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qantara/core/helpers/extentios/extention.dart';
import 'package:qantara/core/theming/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/networking/local/cache_helper.dart';
import '../../core/routing/router.dart';
import '../../core/theming/styles.dart';
import '../../core/widgets/onboarding_button.dart';
import '../../core/widgets/logo_widget.dart';
import '../home/home_screen.dart';
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageController = PageController();
  bool isLast = false;
  List<Map<String,dynamic>> Boarding = [
  {
        "image": "assets/images/onbord_1.png",
        "title": "مع تطبيق قنطرة أصبح الوصول إلى قطع غيار سيارتك من محلات التشاليح أسهل ",
        },
{"image": "assets/images/onbord_2.png",
        "title": "كل قطعة، في متناول يدك",
},
{"image": "assets/images/onbord_3.png",
        "title": "أقرب إليك من أي وقت مضى. اختر قطعتك واطلبها في دقائق",
       },
  ];

  void submit() {
    CacheHelper.saveData(
      key: 'onboarding',
      value: true,
    ).then((value)
    {
      context.pushNamedAndRemoveUntil(Routes.loginScreen, predicate: (Route<dynamic> route)  => false);
    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: ColorsManager.accentPrimaryColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.only(
                top: 30.h,
                bottom: 30.h,
              ),
              child: Container(
                width: double.infinity,
                child: Column(
                  spacing: 30.h,
                  children: [
                    logoWidget(),
                    Container(
                      height: 500,
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: PageView.builder(
                        physics: BouncingScrollPhysics(),
                        controller: pageController,
                        onPageChanged: (int index) {
                          if (index == Boarding.length - 1) {
                            setState(() {
                              isLast = true;
                            });
                          } else {
                            setState(() {
                              isLast = false;
                            });
                          }
                        },
                        itemBuilder: (context, index) => buildItem(Boarding[index]),
                        itemCount: Boarding.length,
                      ),
                    ),
                    SmoothPageIndicator(
                      controller: pageController,
                      effect: ExpandingDotsEffect(
                        dotWidth: 10,
                        dotHeight: 10,
                        spacing: 5,
                        expansionFactor: 4,
                        dotColor: Colors.grey,
                        activeDotColor:ColorsManager.primaryColor,
                      ),
                      count: Boarding.length,
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 15.w),
                      child: OnBoardingButton(event: () {
                        isLast
                            ? submit()
                            : pageController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      },),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
        onWillPop: () async {
          Future.delayed(const Duration(milliseconds: 1000), () {
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          });
          return false;
        });
  }

  Widget buildItem(Map<String,dynamic> item) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Expanded(child: Image(image: AssetImage("${item["image"]}"))),
      SizedBox(
        height: 10,
      ),
      Text(
        "${item["title"]}",
        style: TextStyles.font22BlackBold,
        textAlign: TextAlign.center,
      ),
    ],
  );
}
