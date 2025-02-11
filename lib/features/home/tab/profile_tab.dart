import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qantara/core/helpers/extentios/extention.dart';
import 'package:qantara/core/networking/local/cache_helper.dart';

import '../../../core/routing/router.dart';
import '../../../core/theming/styles.dart';
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          title: Text("الملف الشخصي",style: TextStyles.font20BlackBold ,),
          centerTitle: true,
          leading: IconButton(onPressed: (){}, icon: SvgPicture.asset("assets/images/bell.svg")),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  height: 220,
                    child: Center(
                      child: Stack(
                        alignment: AlignmentDirectional.bottomStart,
                        children: [
                          Image.asset("assets/images/profile.png"),
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: Container(
                              width: 40,
                              height: 40,
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colors.grey.withOpacity(0.3),width: 1)
                              ),
                              child: SvgPicture.asset("assets/images/edit.svg"),
                            ),
                          )
                        ],
                      ),
                    )),
                labelItem("حسابي"),
                itemButton(icon: 'assets/images/edit_user.svg', name: 'تحديث الملف الشخصي', lead: true, event: () {  }),
                itemButton(icon: 'assets/images/eva_pin-fill.svg', name: 'عناوين', lead: true, event: () {  }),
                itemButton(icon: 'assets/images/logout.svg', name: 'تسجيل خروج', lead: false, event: () {
                  CacheHelper.removeData(key: "phone").then((value){
                    context.pushNamedAndRemoveUntil(Routes.loginScreen, predicate: (Route<dynamic> route)=>false);
                  });
                }),
                labelItem("اعدادات لغة التطبيق"),
                itemButton(icon: 'assets/images/Translate.svg', name: 'العربية', lead: true, event: () {  }),
                labelItem("تواصل معنا"),
                itemButton(icon: 'assets/images/chat.svg', name: 'اتصل بنا', lead: false, event: () {  }),
                itemButton(icon: 'assets/images/call.svg', name: 'شروط الاستخدام والخصوصية', lead: false, event: () {  }),
                SizedBox(height: 20.h,),
                TextButton(onPressed: (){}, child: Text("حذف الحساب",style: TextStyle(color: Colors.red,fontSize: 18),)),
                SizedBox(height: 10.h,),
                Text("Directed By Delta Retail Solution",style: TextStyles.font12GreyBold,),
                SizedBox(height: 20.h,),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget labelItem(String text)=>Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 8.h,horizontal: 25.w),
    color: Color(0XFFF6F6F6),
    child: Text(text,style: TextStyles.font16BlackBold,),
  );
  Widget itemButton({
    required String icon,
    required String name,
    required bool lead,
    required Function() event
})=>InkWell(
    onTap: event,
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
    child: Row(
      children: [
        SvgPicture.asset(icon),
        SizedBox(width: 10.w,),
        Text(name,style: TextStyle(fontSize: 18.sp),),
        if(lead)
        Spacer(),
        if(lead)
        Icon(Icons.arrow_forward_ios,color: Colors.grey,weight: 5,)
      ],
    ),
  ),
);
}
